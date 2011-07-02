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
          deliver_media_context(field, field.to_backbone)          
        end
      end.join("\n").html_safe
    end
  
    def deliver_rss(post)
      send(:"#{post.class.name.to_s.underscore}_path", post.slug)
    end
  
    private
  
    def deliver_media_context(context, attrs = {})
      type = context.class.name.underscore
      attrs = { context_type: context.class.name.classify, context_id: context.id.to_s, context_attributes: attrs }
      content_tag(:div, "", { id: "#{type}_context_#{context.id}", data: attrs, class: "#{type}_player" })
    end
    
  end
end