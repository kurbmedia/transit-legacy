class Transit::PostsController < TransitController
  inherit_resources  
  defaults collection_name: 'posts', instance_name: 'post'
  
  helper_method :resource_name, :collection
  respond_to :html, :js, :json
  
  def index
    @posts = resource_class.descending(:post_date).page((params[:page] || 1))
    respond_with(@posts) do |format|
      format.js{ render 'transit/table' }
      format.any
    end
  end
  
  def collection
    @posts
  end
  
  def resource_name; :post; end
  
end