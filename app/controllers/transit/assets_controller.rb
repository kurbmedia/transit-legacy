require 'mime/types'
class Transit::AssetsController < TransitController
  defaults route_instance_name: 'package_asset' 
  
  before_filter :update_params, :only => [:create, :update]
  respond_to :js, :json, :html
  skip_before_filter :verify_authenticity_token
  
  def index
    @parent = params[:resource_type].constantize.find(params[:resource_id])
    @assets = @parent.assets.where(:file_type => 'image')
    respond_with(@assets)
  end
   
  def create
    @asset  = Transit::Asset.new(params[:asset])
    @parent = params[:resource_type].constantize.find(params[:resource_id])
    @asset.assetable = @parent
    @asset.save
    flash[:success] = "Upload successful!"
    render 'create.js.erb'
  end
  
  def show
    @asset = Transit::Asset.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    @asset = Transit::Asset.find(params[:id])
    @asset.destroy
    respond_with(@asset)
  end
  
  private
  
  def update_params
    return true unless params[:asset][:file]
    params[:asset][:file].content_type = ::MIME::Types.type_for(params[:asset][:file].original_filename).first.to_s
  end
  
end