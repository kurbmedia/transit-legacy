class Transit::PagesController < TransitController
  include Transit::Controller::Actions
  respond_to :html, :js, :json
  
  def index
    @pages = scope_class.descending(:post_date).page((params[:page] || 1))
    respond_with(@pages) do |format|
      format.js{ render :partial => 'table' }
      format.any
    end
  end
  
  def edit
    @page = scope_class.find(params[:id])
    respond_with(@page)
  end
  
  def update
    @page = scope_class.find(params[:id])
    unless @page.update_attributes(params[:page])
      flash.now[:error] = "Looks like you were missing a few fields!"
      render :action => :edit and return
    end    
    respond_with(@post, :location => edit_polymorphic_path(@page), :success => "The page '#{@page.name}' has been updated.")
  end
    
end