[:create, :destroy].each do |kind|
  [:before, :after].each do |type|
  
    RSpec::Matchers.define :"have_#{type}_#{kind}_callback" do |expected|
      match do |model|
        callbacks = model.send(:"_#{kind}_callbacks") || []
        !callbacks.detect{ |cb| cb.kind.to_s == type.to_s && cb.raw_filter.to_s == expected.to_s }.nil?
      end
      failure_message_for_should do |model|
        "expected #{ model.name.to_s } to have the #{type}_#{kind} callback '#{expected.to_s}'"
      end
    end
  
  end
end