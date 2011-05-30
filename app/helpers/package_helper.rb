module PackageHelper
  unloadable

  def deliver(obj)
    if obj.respond_to?(:deliver)
      return obj.deliver
    end
    def obj.deliver
      obj.contexts.ascending(:position).map do |field|
      render_to_string(:partial => "contexts/#{field.class.to_s.underscore}", :format => :html, :locals => { :context => field })
      end.join("\n").html_safe
    end
    obj.deliver
  end
  
end