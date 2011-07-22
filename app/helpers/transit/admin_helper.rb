module Transit::AdminHelper
  unloadable
  
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