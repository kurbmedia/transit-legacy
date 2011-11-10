if ENV['TRANSIT_ORM']
  require "transit/orm/#{ENV['TRANSIT_ORM']}"
else
  require "transit/orm/mongoid"
end

require "transit"
require 'transit-social'
require 'transit-admin'