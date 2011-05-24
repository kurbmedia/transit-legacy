class Transit::TransitController < ApplicationController
  
  helper_method :scope_name, :scope_class
  
  def ensure_authenticated!
    redirect_to main_app.root_path and return unless current_user && current_user.admin?    
  end

  def scope_name
    (action_name.to_s === 'index' ? scope_class.to_s.pluralize : scope_class.to_s).underscore
  end
  
  def scope_class
    (params[:scope_name] || self.class.to_s.split("::").first.gsub(/controller/i, '').singularize).constantize
  end
  
  private
  
  def get_instance_var
    instance_variable_get("@#{scope_name}")
  end
  
  def set_instance_var(obj)
    instance_variable_set("@#{scope_name}", obj)
  end
  
end