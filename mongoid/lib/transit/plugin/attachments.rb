module Transit
  module Plugin
    module Attachments
      module ClassMethods
        def attach(name, options = {})          
          options.reverse_merge!(original: '1500x1500>') if options[:styles].present?            
          has_attached_file name, options
          field :"#{name.to_s}_file_name",     :type => String
          field :"#{name.to_s}_content_type",  :type => String
          field :"#{name.to_s}_file_size",     :type => Integer
          field :"#{name.to_s}_updated_at",    :type => Time
          field :"#{name.to_s}_fingerprint",   :type => String          
        end
      end
    end
  end
end