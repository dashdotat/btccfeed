BTCCFeed
========

This script generates a feed containing the main (content) image from a WordPress feed - it's named BTCCFeed as it was originally developed to get an all-in-one feed of content & images for the website BTCCCrazy.co.uk for a planned app, but can be modified for other sites too with minimal problems.

Configuration
-------------

First off, this was developed against Ruby 1.9.3 but there should be nothing specific to 1.9.3 included

To install the required gems (mongo, bson, feedzirra and nokogiri) run

    bundle install

You need Mongo installed and need to edit config/mongoid.yml to use your Mongo instance.

At this point, the easiest way to add a feed is to run

    rake feed:add["<feed_name>,<feed_url>"]

The scripts take care of adding the title from the feed, as well as etag/last-modified to keep transfers down

Finally, you can run

    rake feed:fetch

This will loop through the feeds defined, get and add new articles and also try to add an image with the class "attachment-article" to the data stored in Mongo

Optionally, you can run

    rake feed:fetch["<search>"]

Where <search> is one of the feed name, feed URL or Mongo ObjectID to just fetch that feed

Running

    rake feed:generate

Will generate .json files for each feed, one containing the latest 10 items and one containing all items (named <feed_name>.json and <feed_name>-all.json) which you can then make available to applications

The same as fetch, you can run

    rake feed:generate["<search>"]

To only generate the JSON for the matching feeds (either feed name, feed URL or Mongo ObjectID)

    rake feed:list

Will show you all the feed name and URLs in the system already

Lastly,

    rake feed:delete["<search>"]

Will delete the matching feed (where search is either feed name, feed URL or Mongo ObjectID)

Customising
-----------

Look at lib/feeds.rb for the code which fetchs and generates the feeds

Todo
----

* Tests

Pull requests welcome
