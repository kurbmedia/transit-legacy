module TransitHelper
  
  def deliver(model)
    return model.deliver if model.respond_to?(:deliver)
    result = model.contexts.ascending(:position).to_a.collect do |context|
      method_name = :"deliver_#{context.class.name.underscore}_context"
      if context.respond_to?(:deliver)
        context.deliver
      elsif respond_to?(method_name)
        send(method_name, context)
      else
        render(partial: "contexts/#{context.class.name.to_s.underscore}", format: :html, locals: { context: context })
      end.to_s.html_safe
    end
    result.join("\n").html_safe
  end
  
  def deliver_video_context(context)
    return '' if context.source.to_s.blank?
    attrs = { context_id: context.id.to_s, class: 'video_context', controls: false }
    attrs.merge!(:poster => context.poster) unless context.poster.nil?
    video_tag(context.source, attrs)
  end
  
  def deliver_audio_context(context)
    return '' if context.source.to_s.blank?
    attrs = { context_id: context.id.to_s, class: 'video_context', controls: false }
    audio_tag(context.source, attrs)
  end

  def deliver_rss(post)
    send(:"#{post.class.name.to_s.underscore}_path", post.slug)
  end
end