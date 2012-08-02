require './boot'

puts "Generating feeds"
Feed.all().each do |feed|
  File.open("#{feed.feed_name}.json", 'w') do |f|
    f.write(feed.entries.order_by([:published, :desc]).limit(10).to_json)
    puts " - Generated #{feed.feed_name}.json"
  end
	File.open("#{feed.feed_name}-all.json", 'w') do |f|
    f.write(feed.entries.order_by([:published, :desc]).to_json)
    puts " - Generated #{feed.feed_name}-all.json"
  end
end
