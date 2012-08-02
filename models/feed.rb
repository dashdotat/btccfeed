class Feed
	include Mongoid::Document
	field :feed_url, type: String
	field :feed_title, type: String
	field :feed_etag, type: String
	field :feed_updated, type: DateTime
	field :feed_name, type: String
	has_many :entries
end
