begin
  require 'paperclip'
  def Paperclip.logger
    Rails.logger 
  end
  Paperclip.interpolates(:uid) do |attachment, style|
    "#{attachment.instance.uid}" 
  end
  Paperclip.interpolates(:normalize_name) do |attachment, style|
    "#{attachment.instance.normalize_name(attachment, style)}" 
  end
rescue LoadError
end