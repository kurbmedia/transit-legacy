class Transit::PostsController < TransitController  
  defaults collection_name: 'posts', instance_name: 'post'

  respond_to :html, :js, :json
  
  def collection
    @posts ||= end_of_association_chain.page((params[:page] || 1)).per(15)
  end
  
  def create
    @post = resource_class.new(params[:post])
    set_resource_ivar(@post)
    unless @post.save
      render action: 'new', error: 'Oops, looks like you forgot something!' and return
    end
    redirect_to transit.edit_polymorphic_path(resource), success: 'Your post was created!'
  end
 
  def update
    @post = Post.find(params[:id])
    unless @post.update_attributes(params[:post])
      render action: :edit, error: 'Looks like you forgot a couple fields' and return
    end
    redirect_to transit.edit_polymorphic_path(@post), success: 'Your post was updated.'
  end
  
  def destroy
    destroy!(success: 'The selected post has been deleted.')
  end
  
end