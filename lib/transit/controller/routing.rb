require 'active_support/inflector'

module Transit
  module Controller
    
    module Routing
      extend ActiveSupport::Concern
      
      included do
        ##
        # Generates a route helper for the subclasses of mapped models.
        # This way forms etc work as they should.
        #
        Transit.mappings.each do |mapping|
          parent = mapping.fetch_ref
          parent.subclasses.map(&:to_s).each do |sub|

            plural   = ActiveSupport::Inflector.pluralize(sub).underscore
            singular = sub.underscore
            par      = mapping.class_name.to_s.underscore
            
            helpers = Module.new 
            helpers.module_eval <<-HELPERS, __FILE__, __LINE__
              def new_#{singular}_path(*args)
                new_#{par}_path(*args)
              end                
              def edit_#{singular}_path(*args)
                edit_#{par}_path(*args)
              end                
              def #{plural}_path
                #{mapping.resource.to_s}_path
              end                
              def #{singular}_path(*args)
                #{par}_path(*args)
              end              
            HELPERS
            self.send(:include, helpers)            
            self.send(:helper_method, *[:"new_#{singular}_path", :"#{singular}_path", :"edit_#{singular}_path", :"#{plural}_path"])            
          end
        end
      end
           
    end
    
  end
end