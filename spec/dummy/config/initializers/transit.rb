require "transit"

if ENV['TRANSIT_ORM']
  require "transit/orm/#{ENV['TRANSIT_ORM']}"
else
  require "transit/orm/mongoid"
end