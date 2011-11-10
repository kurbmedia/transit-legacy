require 'transit'

module Transit
  module Admin
    mattr_accessor :authenticate_via
    @@authenticate_via = :authenticate_admin!
    autoload :Tableizer, 'transit/admin/tableizer'
  end
end

require 'kaminari'
require 'transit/admin/engine'