module Transit
  module PackageHelper
    unloadable
    
    def deliver(model)
      return obj.deliver if obj.respond_to?(:deliver)      
      result = capture do
        model.contexts.ascending(:position).each do |context|
          method_name = :"deliver_#{context.class.name.underscore}_context"
          if context.respond_to?(:deliver)
            context.deliver.to_s.html_safe
          elsif respond_to?(method_name)
            send(method_name, context).to_s.html_safe
          else
            render(partial: "contexts/#{context.class.name.to_s.underscore}", format: :html, locals: { context: context }).html_safe
          end
        end
      end
      result.html_safe      
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
end