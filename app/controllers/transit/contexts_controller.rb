class Transit::ContextsController < ApplicationController
  unloadable
  respond_to :js
  helper_method :parent
  
  def new
    @package = scope_class.find(params["#{scope_name}"])
    @context = params[:type].classify.constantize.new
    respond_with(@context)
  end
  
  def destroy
    @package  = scope_class.find(params["#{scope_name}"])
    @context =  @package.contexts.find(params[:id])
    @context.destroy
    flash[:success] = "The selected field has been removed."
    respond_with(@context)
  end
  
  def parent
    @package
  end
  
  def scope_class
    @_scope_class = params.keys.detect{ |k| k.to_s.match(/_id/) }.split("_").first.classify.constantize
  end
  
  def scope_name
    "#{scope_class.to_s.underscore}_id"
  end
  
end