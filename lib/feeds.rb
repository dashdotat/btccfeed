def process_feed(feed)
	puts "Processing #{feed.feed_url}"
	options = {}
	options[:if_modified_since] = feed.feed_updated unless feed.feed_updated.nil?
	options[:if_none_match] = feed.feed_etag unless feed.feed_etag.nil?
	f = Feedzirra::Feed.fetch_and_parse(feed.feed_url, options)
	return if f.nil? || f == 304
	feed.feed_title = f.title unless f.title.nil?
	feed.feed_updated = f.last_modified unless f.last_modified.nil?
	feed.feed_etag = f.etag unless f.etag.nil?
	feed.save

	f.entries.each do |e|
		proces_entry(feed, e)
	end
end

def process_entry(feed, e)
	entry = feed.entries.create(title: e.title, url: e.url, summary: e.summary, author: e.author, content: e.content, published: e.published, entry_id: e.entry_id) unless feed.entries.where(:entry_id => e.entry_id).count > 0
	puts "Added entry #{e.title}"
	doc = Nokogiri::HTML(open(e.url))
	img = doc.xpath('//img[contains(@class,"attachment-article")]').first
	entry.image_url = img['src'] unless img['src'].nil?
	entry.save
	puts " - Set image_url to #{entry.image_url}"
end

def generate_feed(feed)
	File.open("#{feed.feed_name}.json", 'w') do |f|
		f.write(feed.entries.order_by([:published, :desc]).limit(10).to_json)
		puts " - Generated #{feed.feed_name}.json"
	end
	File.open("#{feed.feed_name}-all.json", 'w') do |f|
		f.write(feed.entries.order_by([:published, :desc]).to_json)
		puts " - Generated #{feed.feed_name}-all.json"
	end
end
