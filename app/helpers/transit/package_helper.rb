module Transit
  module PackageHelper
    unloadable
    
    def deliver(obj)
      if obj.respond_to?(:deliver)
        return obj.deliver
      end
      obj.contexts.ascending(:position).map do |field|
        unless field.media_context?
          render(partial: "contexts/#{field.class.to_s.underscore}", format: :html, locals: { context: field }).html_safe
        else
          deliver_media_context(field)          
        end
      end.join("\n").html_safe
    end
  
    def deliver_rss(post)
      send(:"#{post.class.name.to_s.underscore}_path", post.slug)
    end
  
    private
  
    def deliver_media_context(context, attrs = {})
    end
    
  end
end