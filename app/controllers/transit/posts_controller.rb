class Transit::PostsController < TransitController
  
  respond_to :html, :js, :json
  
  def index
    @resources = scope_class.published.descending(:post_date).page((params[:page] || 1)).per(20)
    set_instance_var(@resources)
    respond_with(get_instance_var) do |format|
      format.js{ render :partial => 'table' }
      format.any
    end
  end
  
  
end