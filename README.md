BTCCFeed
========

This script generates a feed containing the main (content) image from a WordPress feed - it's named BTCCFeed as it was originally developed to get an all-in-one feed of content & images for the website BTCCCrazy.co.uk for a planned app, but can be modified for other sites too with minimal problems.

Configuration
-------------

First off, this was developed against Ruby 1.9.3 but there should be nothing specific to 1.9.3 included

To install the required gems (mongo, bson, feedzirra and nokogiri) run

    bundle install

You need Mongo installed and need to edit lib/mongoid.rb to use your Mongo instance.

At this point, the easiest way to add a feed is to run

    irb -r ./boot
    Feed.create(:feed_name => '<feed name>', :feed_url => '<url to RSS feed>'
		^-D

The scripts take care of adding the title from the feed, as well as etag/last-modified to keep transfers down

Finally, you can run
    ruby fetch.rb

This will loop through the feeds defined, get and add new articles and also try to add an image with the class "attachment-article" to the data stored in Mongo

Running
    ruby generate.rb

Will generate .json files for each feed, one containing the latest 10 items and one containing all items (named <feed_name>.json and <feed_name>-all.json) which you can then make available to applications

Customising
-----------

feed.rb is where you need to look to change what data is stored, and what (if any) image is attached to the feed item

generate.rb controls the generation of the .json files, so if you don't want the -all file or want more/less than 10 stories in the latest feed look here.

Todo
----

* Make adding a feed, fetching feeds and generating feeds available as Rake tasks
* Tests

Pull requests welcome
