require 'mime/types'
class Transit::AssetsController < TransitController
  inherit_resources
  
  defaults route_instance_name: 'package_asset', resource_class: Transit::Asset
  belongs_to :post, :page, polymorphic: true, optional: true
  
  before_filter :update_params, :only => [:create, :update]
  respond_to :js, :json, :html

  def create
    @asset  = Transit::Asset.new(params[:asset])
    @asset.assetable = parent
    @asset.save
    flash[:success] = "Upload successful!"
    respond_with(@asset)
  end
  
  private
  
  def update_params
    return true unless params[:asset][:file]
    params[:asset][:file].content_type = ::MIME::Types.type_for(params[:asset][:file].original_filename).first.to_s
  end
  
end