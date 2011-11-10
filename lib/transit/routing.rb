# module ActionDispatch::Routing
#   class Mapper
#     
#     def deliver(*args)
#       options = args.extract_options!
#       cname   = options.delete(:as) || nil
#       mountas = options.delete(:mount_on) || "/transit"
#       
#       Transit::Engine.routes.draw do      
#         args.map(&:to_s).map(&:pluralize).each do |mod|
#           #Transit.add_mapping(mod)
#           cname ||= mod.to_s
#           options.merge!(:controller => "transit/#{cname}")
#           resources mod, options do
#             resources :contexts
#           end
#         end
#       end 
#       
#       unless Transit::RouteTracker.loaded
#         mount Transit::Engine => mountas
#         Transit::RouteTracker.loaded = true
#       end
#       
#     end
#     
#   end
# end
# 
# module Transit
#   module RouteTracker
#     mattr_accessor :loaded
#     @@loaded = false
#   end
# end