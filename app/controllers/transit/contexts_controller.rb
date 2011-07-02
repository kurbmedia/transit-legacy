class Transit::ContextsController < TransitController

  respond_to :js
  belongs_to :post, :page
  actions :new, :destroy
  
  def new
    ptype = symbols_for_association_chain.first.to_s
    @parent = ptype.classify.constantize.find(params["#{ptype}_id"])
    set_resource_ivar(@parent)
    @context = @parent.contexts.build({}, params[:type].classify.constantize)
    respond_with(@context)
  end
  
    
  def destroy
    ptype = symbols_for_association_chain.first.to_s
    @parent = ptype.classify.constantize.find(params["#{ptype}_id"])
    @context = @parent.contexts.find(params[:id])
    set_resource_ivar(@parent)
    @context.destroy
    flash[:success] = "The selected field has been removed."
    respond_with(@context)
  end
  
end