class Transit::PagesController < TransitController
  inherit_resources
  respond_to :html, :js, :json  
  defaults collection_name: 'pages', instance_name: 'page'

  respond_to :html, :js, :json
  
  def collection
    @pages ||= end_of_association_chain.page((params[:page] || 1)).per(20)
  end
  
  def edit
    @page = Page.find(params[:id])
    respond_with(@page)
  end
  
  def update
    @page = Page.find(params[:id])
    unless @page.update_attributes(params[:page])
      flash.now[:error] = "Looks like you were missing a few fields!"
      render :action => :edit and return
    end    
    respond_with(@page, :location => transit.edit_polymorphic_path(@page), :success => "The page '#{@page.name}' has been updated.")
  end
    
end