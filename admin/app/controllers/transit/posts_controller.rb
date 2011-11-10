class Transit::PostsController < TransitController  
#  has_scope :page, :default => 1
  inherit_resources
  
  def self.extended(klass)
    klass.class_eval do
      defaults :instance_name => klass.name.to_s.singularize.underscore
    end
    super
  end
  
  defaults :collection_name => 'posts', :instance_name => 'post'
  respond_to :html, :js, :json

  def collection
    end_of_association_chain.page((params[:page] || 1)).per(15)
  end

  def create
    create!{ transit.edit_polymorphic_path(resource) }
  end

  def update
    update!{ transit.edit_polymorphic_path(resource) }
  end

  def destroy
    destroy!(success: 'The selected post has been deleted.')
  end

end