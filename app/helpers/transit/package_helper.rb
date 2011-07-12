module Transit
  module PackageHelper
    unloadable
    
    def deliver_content(resource, force_edit = false, &block)
      return capture(resource, &block).html_safe unless force_edit || edit_mode_enabled?
      tpl  = resource.delivery_template
      with_output_buffer do
        concat(form_for([transit, resource], as: tpl, html: { remote: true, id: "transit_edit_#{tpl.to_s}" }) do |dform|
          concat(capture(Transit::Builders::PackageBuilder.new(resource, dform, nil), &block))
        end)
      end
    end
    
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
  
    def add_transit_meta( context )
      @_transit_metadata ||= {}      
      metadata = ::Base64.encode64s(context.to_json)
      @_transit_metadata.merge!("context:#{context.id}" => metadata )
    end
  
    def deliver_media_context(context, attrs = {})
      add_transit_meta( context )
      type = context.class.name.underscore 
      meta = context.to_html.dup
      meta.delete(:context_attributes)
      attrs.merge!( meta )
      html_attrs = { id: "#{type}_context_#{context.id}", data: attrs, class: "#{type}_player" }      
      content_tag(:div, "", html_attrs)
    end
    
  end
end