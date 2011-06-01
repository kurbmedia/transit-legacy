require 'mime/types'
class Transit::AssetsController < TransitController
  
  before_filter :update_params, :only => [:create, :update]
  respond_to :js, :json
  respond_to :html, :only => :index
   
  def create
    
    post_ids = params.delete(:post_ids)
    page_ids = params.delete(:page_ids)
    
    @asset = Transit::Asset.new(params[:asset])
    [post_ids].flatten.compact.each{ |p| @asset.posts << Transit::Post.find(params[:id]) }
    [page_ids].flatten.compact.each{ |p| @asset.pages << Transit::Page.find(params[:id]) }
    @asset.save
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