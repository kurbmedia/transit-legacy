class Transit::TopicsController < TransitController
  belongs_to :post, optional: true
  respond_to :js
  
end