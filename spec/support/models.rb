module ModelHelpers
  
  def change_and_reset_attribute(obj, atr, newval)
    before do 
      subj = instance_variable_get("@#{obj}")
      @old_value = subj.attributes[atr]; subj.attributes[atr] = nil
    end    
    after do
      subj = instance_variable_get("@#{obj}")
      subj.attributes[atr] = @old_value
    end
  end
  
  def generate_post(ct = 1, attrs = {}, set_subject = true, scope = :each, remove_after = true)
    before(scope) do
      ct.times do |i|
        instance_variable_set("@post#{i+1}", Fabricate(:post, attrs))                
      end      
    end
    ct.times{ |i| 
      let("post#{i+1}"){ instance_variable_get("@post#{i+1}") } 
    }
    if set_subject
      subject{ @post1 }
    end
    if remove_after
      after(scope){ Post.delete_all }
    end
  end
  
  def generate_full_post(attrs = {}, scope = :all)
    before(scope) do
      sentences = Faker::Lorem.sentences(3)
      @post = Fabricate.build(:post, attrs.merge(:teaser => sentences.first))      
      @post.contexts.build(Fabricate.attributes_for(:context, :body => sentences.map{ |sent| "<p>#{sent}</p>" }), Text)
      @post.save
    end
    subject{ @post }
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