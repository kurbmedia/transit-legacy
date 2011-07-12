require 'motr'

module ApplicationHelper
  include Motr::Helpers::Elements
  include Motr::Helpers::Navigation
  include Motr::Helpers::LayoutHelpers
  include Transit::AdminHelper
  include TransitHelper
end
