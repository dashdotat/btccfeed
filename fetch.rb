require './boot'

feeds = Feed.where(:feed_url.ne => nil)
feeds.each do |feed|
	puts "Processing #{feed.feed_url}"
	options = {}
	options[:if_modified_since] = feed.feed_updated unless feed.feed_updated.nil?
	options[:if_none_match] = feed.feed_etag unless feed.feed_etag.nil?
	f = Feedzirra::Feed.fetch_and_parse(feed.feed_url, options)
	next if f.nil?
	feed.feed_title = f.title unless f.title.nil?
	feed.feed_updated = f.last_modified unless f.last_modified.nil?
	feed.feed_etag = f.etag unless f.etag.nil?
	feed.save

	f.entries.each do |e|
		entry = feed.entries.create(title: e.title, url: e.url, summary: e.summary, author: e.author, content: e.content, published: e.published, entry_id: e.entry_id) unless feed.entries.where(:entry_id => e.entry_id).count > 0
		puts "Added entry #{e.title}"
		doc = Nokogiri::HTML(open(e.url))
		img = doc.xpath('//img[contains(@class,"attachment-article")]').first
		entry.image_url = img['src'] unless img['src'].nil?
		entry.save
		puts " - Set image_url to #{entry.image_url}"
	end
end
