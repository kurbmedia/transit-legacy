module TransitHelper  
  unloadable
  
  include Transit::PackageHelper
  include Transit::PaginationHelper
  include Transit::FormHelper
  
  def transit_assets
    return '' unless controller.class.name.match(/Transit/)
    stylesheet_link_tag('transit') <<
    javascript_include_tag('https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.13/jquery-ui.min.js') <<
    javascript_include_tag('transit/admin')
  end
  
  def transit_metadata
    return "" unless @_transit_metadata && @_transit_metadata.is_a?(Hash)
    out = ""
    @_transit_metadata.each do |name, data|
      out << tag(:meta, name: name, content: data)
    end
    out.html_safe
  end
  
  def video_player(source, html_attrs = {})
    attrs = { 
      id: "video_player_#{Time.now.to_i}",
      class: 'video_player' 
    }
    wrapper    = html_attrs.delete(:wrapper) || :div
    data_attrs = { source: source, ext: File.extname(source).sub('.','') };
    
    if img = html_attrs.delete(:image)
      data_attrs.merge!(image: img)      
    end
    
    html_attrs.reverse_merge!( attrs.merge!(data: { context_attributes: Base64.encode64s(data_attrs.to_json) } ))
    content_tag(wrapper, "", html_attrs)
  end
  
  def audio_player(source, html_attrs = {})
    attrs = { 
      id: "audio_player_#{Time.now.to_i}",
      class: 'audio_player' 
    }
    wrapper = html_attrs.delete(:wrapper) || :div
    data_attrs = { source: source }
    html_attrs.reverse_merge!( attrs.merge!(data: { context_attributes: Base64.encode64s(data_attrs.to_json) }) )
    content_tag(wrapper, "", html_attrs)
  end
  
end