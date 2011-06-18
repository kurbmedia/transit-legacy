module Transit::FormHelper
 unloadable
 
 def render_inline_post_field(method, form)
   render_inline_field(:posts, method, form)
 end
 
 def render_inline_field(type, method, form)
  render partial: "transit/#{type.to_s}/fields/#{method.to_s}", locals: { form: form }
 end
 
 def render_widget(name, form, html_opts = {})
   render partial: "transit/widgets/#{name}", locals: { form: form }
 end
 
 def render_fields_for(model, pack, form)
   return '' unless model.delivers?(pack)
   render partial: "transit/#{pack.to_s}/model", locals: { form: form, parent: model }
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