class Entry
	include Mongoid::Document
	belongs_to :feed
	field :title, type: String
	field :url, type: String
	field :summary, type: String
	field :author, type: String
	field :content, type: String
	field :published, type: DateTime
	field :entry_id, type: String
	field :image_url, type: String
  field :categories, type: Array
  field :body, type: String
end
