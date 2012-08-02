require 'rubygems' unless defined?(Gem)
require 'bundler'
require 'open-uri'

Bundler.require()

Dir["./lib/*.rb", "./models/*.rb"].each do |f|
	require f
end
