class Post
  include Mongoid::Document
  transit :post
end
class Article < Post
end

class ContextField < Transit::Context
end

class BodyCopy < Transit::Context
end

class Heading < Transit::Context
end

Fabricator(:context, :class_name => :context_field) do
  name ""
  meta {}
  body Faker::Lorem.words(3).join(" ")
end

Fabricator(:post) do
  title Faker::Lorem.words(3)  
end

module ModelHelpers
  
  def generate_post(ct = 1, set_subject)
    before do
      ct.times do |i|
        instance_variable_set("@post#{i+1}", Fabricate(:post))                
      end      
    end
    ct.times{ |i| 
      let("post#{i+1}"){ instance_variable_get("@post#{i+1}") } 
    }
    if set_subject
      subject{ @post1 }
    end
  end
  
  def create_contexts(parent, scope = :each, *klasses)
    before(scope) do
      klasses = [ContextField] if klasses.empty?
      klasses.flatten.each do |k|
        instance_variable_get("@#{parent}").contexts.create(Fabricate.attributes_for(:context), k)
      end
    end
    after(scope) do
      instance_variable_get("@#{parent}").contexts.delete_all
    end
  end
  
end