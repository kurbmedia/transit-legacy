module PackageHelper
  unloadable

  def deliver(obj)
    if obj.respond_to?(:deliver)
      return obj.deliver
    end
    obj.contexts.ascending(:position).map do |field|
      case field
      when Video then deliver_media_context('video', field, { video_source: field.body, video_type: field.video_type })
      when Audio then deliver_media_context('audio', field, { audio_source: field.body })
      else
        render(:partial => "contexts/#{field.class.to_s.underscore}", :format => :html, :locals => { :context => field }).html_safe
      end
    end.join("\n").html_safe
  end
  
  def deliver_rss(post)
    send(:"#{post.class.name.to_s.underscore}_path", post.slug)
  end
  
  private
  
  def deliver_media_context(type, context, attrs = {})
    content_tag(:div, "", { id: "#{type}_player_#{context.id}", data: attrs }, class: "#{type}_player")
  end
  
end