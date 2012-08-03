require './boot'

task :default => ["feed:list"]

namespace 'feed' do
	desc "List feeds"
	task :list do
		puts "Listing feeds"
		puts "============="
		Feed.all().each do |feed|
			puts "Name: #{feed["feed_name"]} URL: #{feed["feed_url"]}"
		end
	end

	desc "Add feed : [<feed_name>,<feed_url>]"
	task :add, [:feed_name, :feed_url] do |t,args|
		if args.feed_name.nil? || args.feed_url.nil?
			puts "Must specify feed name and url"
		else
			f = Feed.create(:feed_name => args.feed_name, :feed_url => args.feed_url)
			puts "Created feed #{args.feed_name} with ObjectID #{f._id}"
		end
	end

	desc "Delete feed : [<feed_name|feed_url|ObjectID>]"
	task :delete, [:search] do |t,args|
		if args.search.nil?
			puts "Must specify search item"
		else
			feeds = Feed.any_of({feed_name: args.search}, {feed_url: args.search}, {_id: args.search})
			feeds.each do |f|
				puts "Deleting feed #{f["feed_name"]} (#{f["feed_url"]})"
				f.destroy
			end
		end
	end

	desc "Fetch feeds : [(feed_name|feed_url|ObjectID)]"
	task :fetch, [:search] do |t,args|
		if args.search.nil?
			feeds = Feed.all().where(:feed_url.ne => nil)
		else
			feeds = Feed.any_of({feed_name: args.search}, {feed_url: args.search}, {_id: args.search}).where(:feed_url.ne => nil)
		end
		feeds.each do |f|
			process_feed f			
		end
	end

	desc "Generate feeds : [(feed_name|feed_url|ObjectID)]"
	task :generate, [:search] do |t,args|
		if args.search.nil?
			feeds = Feed.all()
		else
			feeds = Feed.any_of({feed_name: args.search}, {feed_url: args.search}, {_id: args.search})
		end
		feeds.each do |f|
			generate_feed f
		end
	end
end
