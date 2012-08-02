Mongoid.configure do |config|
	config.master = Mongo::Connection.new.db("btccfeed")
end
