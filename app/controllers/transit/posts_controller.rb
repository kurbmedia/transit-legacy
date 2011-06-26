class Transit::PostsController < TransitController  
  defaults collection_name: 'posts', instance_name: 'post'

  respond_to :html, :js, :json
  
  def collection
    @posts ||= end_of_association_chain.page((params[:page] || 1), per: 20)
  end
  
  def create
    create!(success: 'Your post was created!'){ edit_polymorphic_path(resource) }
  end
  
  def update
    @post = Post.find(params[:id])
    unless @post.update_attributes(params[:post])
      render action: :edit, error: 'Looks like you forgot a couple fields' and return
    end
    redirect_to transit.edit_polymorphic_path(@post), success: 'Your post was updated.'
  end
  
end