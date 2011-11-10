module Transit
  module FormHelper
   
    def manage_delivery_for(context, form)
      mname = :"edit_#{context.class.name.to_s.underscore}_context"
      return send(mname, context, form) if respond_to?(mname)
      render(:partial => "transit/contexts/edit_#{context.class.name.to_s.underscore}", :locals => { :context => context, :form => form })
    end
    alias :manage_delivery :manage_delivery_for
   
    private
   
    def edit_audio_context(context, form)
      _wrap_context_field(context) do
        deliver(context) <<
        content_tag(:ol) do
          content_tag(:li, [form.label(:source), form.text_field(:source, value: context.body)].join("\n").html_safe)
        end
      end
    end
   
    def edit_video_context(context, form)
      _wrap_context_field(context) do
        deliver(context) <<
        content_tag(:ol) do
          content_tag(:li, [form.label(:source), form.text_field(:source, value: context.body)].join("\n").html_safe)
        end
      end
    end
    
    def _wrap_context_field(context, &block)
      content_tag(:div, capture(&block), :class => "edit-<%= context.class.name.underscore %>-context")
    end
    
  end
end