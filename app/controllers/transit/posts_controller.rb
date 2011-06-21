class Transit::PostsController < TransitController
  defaults collection_name: 'posts', instance_name: 'post'
  
  helper_method :resource_name, :collection
  respond_to :html, :js, :json
  
  def collection
    @posts ||= end_of_association_chain.paginate(page: (params[:page] || 1))
  end
  
  def resource_name; :post; end
  
end