require 'paperclip'

module Transit
  module Plugin
    module Attachments
      extend ActiveSupport::Concern

      module ClassMethods
        ##
        # Convenience method for Paperclip's has_attached_file to ensure original files are 
        # also processed. This helps save space when large images are uploaded for web purposes
        # 
        def attach(name, options = {})          
          options[:styles].reverse_merge!(:original => '1500x1500>') if options[:styles].present?            
          has_attached_file name, options
        end
      end
      
    end    
  end
end