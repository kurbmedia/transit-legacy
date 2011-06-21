module Transit::FormHelper
  
  def form_for(record_name_or_array, *args, &proc)

    options = args.extract_options!
    options.reverse_merge!(:builder => Transit::Builders::Forms)
    options[:html] ||= {}
    options[:html].merge!('data-js-validatable' => true) if options.delete(:validate)

    super(record_name_or_array, *(args << options), &proc)
    
  end
  
end