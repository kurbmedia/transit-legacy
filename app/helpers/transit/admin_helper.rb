module Transit::AdminHelper
  unloadable

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