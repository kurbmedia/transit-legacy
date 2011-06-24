module Transit
  module PackageHelper
    unloadable
    
    
    
    def deliver(obj)
      if obj.respond_to?(:deliver)
        return obj.deliver
      end
      obj.contexts.ascending(:position).map do |field|
        case field
        when Video || Audio then deliver_media_context(field, CGI::escape(field.data.to_json))
        else
          render(:partial => "contexts/#{field.class.to_s.underscore}", :format => :html, :locals => { :context => field }).html_safe
        end
      end.join("\n").html_safe
    end
  
    def deliver_rss(post)
      send(:"#{post.class.name.to_s.underscore}_path", post.slug)
    end
  
    private
  
    def deliver_media_context(context, attrs = {})
      type = context.class.name.underscore
      attrs = { transit_context: type, context_options: attrs }
      content_tag(:div, "", { id: "#{type}_context_#{context.id}", data: attrs, class: "#{type}_player" })
    end
    
  end
end