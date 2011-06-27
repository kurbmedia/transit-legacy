class Transit::ContextsController < TransitController

  respond_to :js
  belongs_to :post, :page, polymorphic: true
  actions :new, :destroy
  
  def new
    ptype = symbols_for_association_chain.first.to_s
    parent_obj = ptype.classify.constantize.find(params["#{ptype}_id"])
    set_resource_ivar(parent_obj)
    @context = parent_obj.contexts.build({}, params[:type].classify.constantize)
    respond_with(@context)
  end
  
    
  def destroy
    parent.contexts.find(params[:id])
    @context.destroy
    flash[:success] = "The selected field has been removed."
    respond_with(@context)
  end
  
end