#require 'spork'

#Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # Configure Rails Envinronment
  ENV["RAILS_ENV"] = "test"      
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)  
  require 'active_support'
  require "rspec/rails"
  require 'mongoid'
  require 'fabrication'
  require 'ffaker'
  require 'rails'


  Mongoid.configure do |config|
    config.master = Mongo::Connection.new.db("transit_dev_test")
  end


  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_url_options[:host] = "test.com"

  Rails.backtrace_cleaner.remove_silencers!

  # Configure capybara for integration testing
  require "capybara/rails"
  Capybara.default_driver   = :rack_test
  Capybara.default_selector = :css

  # Load support files
  Dir["#{File.dirname(__FILE__)}/fabricators/**/*.rb"].each { |f| require f }
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  RSpec.configure do |config|
    config.mock_with :mocha
    config.include Mongoid::Matchers
    config.after :suite do
      Mongoid.master.collections.select do |collection|
        collection.name !~ /system/
      end.each(&:drop)
    end
  end
  
#end

Spork.each_run do
  # This code will be run each time you run your specs.
  Dir["#{File.dirname(__FILE__)}/fabricators/**/*.rb"].each { |f| require f }
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
  Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each { |f| require f }
end
