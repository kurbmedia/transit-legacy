class Transit::ContextsController < Transit::TransitController
  include Transit::Helpers::ControllerHelpers
  
  unloadable
  
  before_filter :ensure_authenticated!  
  respond_to :js
  
  def new
    @package = scope_class.find(params["#{scope_name}"])
    @context = params[:type].classify.constantize.new
    respond_with(@context)
  end
  
  def destroy
    @package  = scope_class.find(params["#{scope_name}"])
    @context =  scope_class.find(params[:id])
    @field.destroy
    flash[:success] = "The selected field has been removed."
    respond_with(@field)
  end
  
end