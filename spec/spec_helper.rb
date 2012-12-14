require 'spork'
require 'ruby-debug'

Spork.prefork do
	ENV["RAILS_ENV"] ||= 'test'
	require File.expand_path("../../config/environment", __FILE__)
	require 'rspec/rails'
	require 'rspec/autorun'
	require 'database_cleaner'

	Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

	RSpec.configure do |config|
		config.mock_with :rspec

		config.before(:suite) do
			DatabaseCleaner.strategy = :truncation
			DatabaseCleaner.orm = "mongoid"
		end

		config.before(:each) do
			DatabaseCleaner.clean
		end
	end

end

Spork.each_run do
	require "#{Rails.root}/config/routes.rb" 
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| require f }
end


