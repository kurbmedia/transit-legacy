module Transit
  module FormHelper
   unloadable
   
   def render_fields_for(model, pack, form)
     return '' unless model.delivers?(pack)
     render partial: "transit/#{pack.to_s}/model", locals: { form: form, parent: model }
   end
    
  end
end