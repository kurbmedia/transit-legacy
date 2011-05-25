class Transit::PackagesController < Transit::TransitController
  include Transit::Helpers::ControllerHelpers
  
  unloadable
  before_filter :ensure_authenticated!
  
  respond_to :html, :js
  
  def index
    @packages = scope_class.descending(:created_at).all.paginate :per_page => 20, :page => (params[:page] || 1)
    set_instance_var(@packages)
    respond_with(get_instance_var) do |format|
      format.js{ render :partial => 'table' }
      format.any
    end
  end
  
  def show
    @package = scope_class.find(params[:id])
    set_instance_var(@package)
    respond_with(get_instance_var)
  end
  
  def new
    @package = scope_class.new
    set_instance_var(@package)
    respond_with(get_instance_var)
  end
  
  def create
    @package = scope_class.new(params["#{scope_name}"])
    unless @package.save
      flash.now[:error] = "Oops! Looks like you missed a couple fields."
      render :action => :new and return
    end
    set_instance_var(@package)
    flash[:success] = "'#{package.title}' has been created."
    respond_with(get_instance_var, :location => edit_polymorphic_path([:transit, @package]))    
  end
  
  def edit
    @package = scope_class.find(params[:id])
    set_instance_var(@package)
    respond_with(@package)
  end
  
  def update
    @package = scope_class.find(params[:id])
    unless @package.update_attributes(params["#{scope_name}"])
      flash.now[:error] = "Looks like you were missing a few fields!"
      render :action => :edit and return
    end    
    flash[:success] = "'#{@package.title}' has been updated."
    set_instance_var(@package)
    respond_with(get_instance_var, :location => edit_polymorphic_path([:transit, @package]))    
  end
  
  def destroy
    @package = scope_class.find(params[:id])
    @package.destroy
    set_instance_var(@package)
    flash[:success] = "'#{@package.title}' has been deleted."
    respond_with(get_instance_var, :location => polymorphic_path([:transit, @package]))
  end
  
end