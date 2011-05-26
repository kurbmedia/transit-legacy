module ActionDispatch::Routing
  class Mapper
    def transit(*models)
      options = models.extract_options!
      Transit::Engine.routes.draw do
        models.map(&:to_s).map(&:pluralize).each do |mod|
          resources mod, :controller => "#{mod}"
        end
      end
      mount Transit::Engine => (options[:mount_on] || "/transit")
    end
    
  end
end