module PackageHelper
  unloadable

  def deliver(obj)
    if obj.respond_to?(:deliver)
      return obj.deliver
    end
    obj.contexts.ascending(:position).map do |field|
      render(:partial => "contexts/#{field.class.to_s.underscore}", :format => :html, :locals => { :context => field })
    end.join("\n").html_safe
  end
  
end