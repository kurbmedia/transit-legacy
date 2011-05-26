class Transit::PostsController < Transit::PackagesController
end

class Transit::ArticlesController < Transit::PackagesController
end

module ControllerHelpers
  def stub_resource(klass)
    before do
      resource  = stub("#{klass.to_s}", Fabricate.attributes_for(:"#{klass.to_s.underscore}"))
      resource.responds_like(klass.new)
      resource.stubs(:id).returns(1)
      resources = (1..5).collect{ resource }
      klass.stubs(:all).returns(resources)
      klass.stubs(:descending).returns(klass)
      klass.stubs(:find).returns(resource)
      klass.stubs(:name).returns(klass.to_s)
      instance_variable_set("@#{klass.to_s.underscore}", resource)
      instance_variable_set("@#{klass.to_s.pluralize.underscore}", resources)
    end
    let(:resource){ instance_variable_get("@#{klass.to_s.underscore}") }
    let(:resources){ instance_variable_get("@#{klass.to_s.pluralize.underscore}") }
  end
end

Transit::Engine.routes.draw do
  resources :posts
  resources :articles
end