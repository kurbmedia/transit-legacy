module TransitHelper
  
  def transit_assets
    return stylesheet_link_tag 'transit' if controller.class.name.match(/Transit/)
  end
  
end