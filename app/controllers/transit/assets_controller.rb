require 'mime/types'
class Transit::AssetsController < TransitController
  
  before_filter :update_params, :only => [:create, :update]
  respond_to :js, :json, :html
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_for_transit!
  skip_before_filter :authenticate_admin!
   
  def create
    @asset  = Transit::Asset.new(params[:asset])
    @parent = params[:resource_type].constantize.find(params[:resource_id])
    @asset.assetable = @parent
    @asset.save
    Rails.logger.info("adlsakjdlaskjdklasdjklsajsakldjlkadajslkdaj")
    flash[:success] = "Upload successful!"
    respond_with(@asset)    
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