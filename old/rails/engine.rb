require 'rails'
require 'paperclip'

module Transit
  class Engine < Rails::Engine

    isolate_namespace Transit
    
    paths['app/models']  << 'app/models/contexts'
    paths['app/helpers'] << 'app/helpers/transit'
    
    config.transit = Transit::Config
    
    initializer 'transit.paperclip' do
      def Paperclip.logger
        Rails.logger 
      end      
      ::Paperclip.interpolates(:uid) do |attachment, style|
        "#{attachment.instance.uid}" 
      end
      ::Paperclip.interpolates(:normalize_name) do |attachment, style|
        "#{attachment.instance.normalize_name(attachment, style)}" 
      end
    end
          
  end
end

require 'transit/rails/railtie'