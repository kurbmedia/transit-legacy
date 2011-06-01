class Transit::PostsController < TransitController
  unloadable
  respond_to :html, :js, :json
  
  def index
    @posts = Transit::Post.published.descending(:post_date).page((params[:page] || 1)).per(20)
    respond_with(@posts) do |format|
      format.js{ render :partial => 'table' }
      format.any
    end
  end
  
  def new
    @post = scope_class.new
  end
  
  def create
    @post = scope_class.new(params[:post])    
    unless @post.save
      flash.now[:error] = "Oops! Looks like you missed a couple fields."
      render :action => :new and return
    end
    
    flash[:success] = "The post '#{@post.title}' has been created."
    respond_with(@post, :location => edit_polymorphic_path(@post))    
  end
  
  def edit
    @post = scope_class.find(params[:id])
    respond_with(@post)
  end
  
  def update
    @post = scope_class.find(params[:id])
    unless @post.update_attributes(params[:post])
      flash.now[:error] = "Looks like you were missing a few fields!"
      render :action => :edit and return
    end    
    flash[:success] = "The post '#{@post.title}' has been updated."
    respond_with(@post, :location => edit_polymorphic_path(@post))    
  end
  
  def destroy
    @post = scope_class.find(params[:id])
    @post.destroy
    flash[:success] = "The selected post was deleted."
    respond_with(@post, :location => posts_path)
  end
  
end