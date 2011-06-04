module TransitHelper
  unloadable
  
  def transit_toolbar
    render :partial => 'transit/toolbar/base'
  end
  
  def transit_assets
    return '' unless controller.class.name.match(/Transit/)
    stylesheet_link_tag('transit') <<
    javascript_include_tag('transit')
  end
  
end