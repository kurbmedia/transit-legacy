module TransitHelper
  
  def deliver(model)
    _deliver_context(model).html_safe
  end
  
  def deliver_video_context(context, attrs = {}, show = false)
    return '' if context.source.to_s.blank? && show == false
    attrs ||= {}
    attrs.merge!({ :data => { :context_id => context.id.to_s }, :class => 'video-context', :controls => false })
    attrs.merge!(:poster => context.poster) unless context.poster.nil?
    content_tag(:video, "", attrs.merge(:src => context.source))
  end
  
  def deliver_audio_context(context, attrs = {}, show = false)
    return '' if context.source.to_s.blank? && show == false
    attrs ||= {}
    attrs.merge!({ :data => { :context_id => context.id.to_s }, :class => 'audio-context', :controls => false })
    content_tag(:audio, "", attrs.merge(:src => context.source))
  end

  def deliver_rss(post)
    send(:"#{post.class.name.to_s.underscore}_path", post.slug)
  end
  
  private
  
  def _deliver_context(model)
    return model.deliver if model.respond_to?(:deliver)
    with_output_buffer do
      model.contexts.ascending(:position).to_a.each do |context|
        method_name = :"deliver_#{context.class.name.underscore}_context"
        if context.respond_to?(:deliver)
          concat context.deliver
        elsif respond_to?(method_name)
          concat send(method_name, context)
        else
          concat render(partial: "transit/contexts/#{context.class.name.to_s.underscore}", format: :html, locals: { context: context })
        end
      end
    end  
  end
  
end