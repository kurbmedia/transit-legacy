module Transit::FormHelper
 def context_field_item(field, form)
   idfield = field.new_record? ? "" : form.hidden_field(:id)
   content_tag(:li, { class: "field field_#{field.class.to_s.underscore}" }) do
     form.hidden_field(:_type, value: field.class.to_s) <<
     form.hidden_field(:position, rel: 'field_position') <<
     idfield <<
     render(partial: "transit/contexts/#{field.class.to_s.underscore}", locals: { form: form, context: field })
   end.html_safe
 end
 
 def transit_toolbar(model, &block)
   content_tag(:div, capture(&block), { class: 'ui-widget-header ui-state-default', id: 'transit_toolbar' })
 end
 
 def toolbar_button(text, url, attrs)
   klasses = attrs[:class].to_s.split(" ").push('transit_toolbar_button')
   if attrs[:icon].present?
     (attrs[:data] ||= {}).merge!("ui-icon" => "ui-icon-#{attrs.delete(:icon)}")
   end
   link_to text.html_safe, url, attrs.merge(class: klasses.join(" ")) 
 end
 
 def file_icon_class(asset)
   ext = File.extname(asset.file_file_name.to_s.downcase).gsub('.', '')
   extnames = { 
     'powerpoint' => ['ppt','pptx','key'],
     'audio'      => ['mp3', 'wav'],
     'video'      => ['mp4', 'wmv', 'mov', 'mpeg'],
     'flash'      => ['swf', 'flv', 'fla'],
     'pdf'        => ['pdf'],
     'word'       => ['doc', 'docx', 'pages'],
     'excel'      => ['xls', 'csv', 'xlsx', 'numbers'],
     'image'      => ['tiff', 'tif', 'bmp', 'jpeg', 'jpg', 'png', 'gif'],
     'vector'     => ['ai', 'eps']
   }
   choice = 'file'
   extnames.each_pair{ |key, value|  choice = key if value.include?(ext) }
   "file_icon_#{choice}"
 end
  
end