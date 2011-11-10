class Transit::ContextsController < TransitController
  inherit_resources
  
  respond_to :js
  belongs_to :post, :page, polymorphic: true
  actions :new, :destroy
  
  def new
    parent_resource = create_parent
    context_class   = params[:type].classify.constantize
    set_resource_ivar(parent_resource)
    type_col = context_class.inheritance_column
    
    # Build a new context on the parent, casting to the 
    # specified type.
    # 
    @context = parent_resource.contexts.build({ type_col => context_class.name })
    @context = @context.becomes(context_class)
    respond_with(@context)
  end
  
    
  def destroy
    parent.contexts.find(params[:id])
    @context.destroy
    flash[:success] = "The selected field has been removed."
    respond_with(@context)
  end
  
  
  private
  
  def create_parent
    ptype      = symbols_for_association_chain.first.to_s
    ptype.classify.constantize.find(params["#{ptype}_id"])
  end
  
end