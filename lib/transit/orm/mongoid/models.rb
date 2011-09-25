module Transit
  module Plugin
    module Attachments
      module ClassMethods
        def attach(name, options = {})
          include ::Paperclip::Glue          
          
          options[:styles].reverse_merge!(:original => '1500x1500>') if options[:styles].present?
          send(:field, :"#{name}_file_name", :type => String)
          send(:field, :"#{name}_content_type", :type => String)
          send(:field, :"#{name}_updated_at", :type => DateTime)
          send(:field, :"#{name}_fingerprint", :type => String)
          
          has_attached_file name, options          
        end
      end
    end    
  end
end

module Transit
  class Context
    include ::Mongoid::Document
  end
end

module Transit
  class Asset
    include ::Mongoid::Document
  end
end