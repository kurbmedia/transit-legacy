class Transit::TopicsController < TransitController
  inherit_resources
  belongs_to :post, optional: true
  respond_to :js
  
end