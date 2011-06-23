class Transit::PostsController < TransitController
  defaults collection_name: 'posts', instance_name: 'post'
  
  helper_method :resource_name, :collection
  respond_to :html, :js, :json
  
  def collection
    @posts ||= end_of_association_chain.page((params[:page] || 1), per: 20)
  end
  
  def update
    update! do |success, failure|
      failure.any { render 'edit' }
      success.html{ redirect_to edit_polymorphic_path(resource) }
    end
  end
  
  def resource_name; :post; end
  
end