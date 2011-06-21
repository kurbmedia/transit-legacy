module Transit  
  module Builders
    
    ##
    # Base class for creating form builders
    # 
    class Forms < ActionView::Helpers::FormBuilder #:nodoc:
      
      # Access the template object
      attr_accessor :template
      # Tracks the order in which fields are used in the form, this allows the easy rebuilding of the submitted form
      # data when submitted since normally the hash isn't ordered.
      attr_accessor :field_order
      # Tracks the field currently being "processed"
      attr_accessor :current_field_type

      # create overrides for custom rendering
      [:email_field, :password_field, :text_field, :text_area, :url_field].each do |method|      
        class_eval <<-FUNC, __FILE__, __LINE__ + 1

          alias :_super_#{method} :#{method}

          def #{method}(method_name, *args)
            render_field_as_custom(:#{method}, method_name, *args)
          end
        FUNC
      end

      ##
      # Modified label tag to support adding a 'required' asterisk to the end of the label.
      # Same params as the original implementation
      # 
      def label(method, text = nil, options = {}, &block) #:nodoc:

        options, text = text, nil if text.is_a?(Hash)
        text ||= method.to_s.humanize

        options.stringify_keys!
        klasses = (options.delete(['class']) || "").split(" ")
        klasses << 'field_with_errors' if errors_on_attribute?(method)
        options['class'] = klasses.join(" ") unless klasses.compact.empty?

        text = "#{text} <abbr title='Required'>*</abbr>".html_safe  if attribute_required?(method) || required_by_option?(options.delete('required'))        
        super(method, text, options, &block)

      end

      ##
      # 
      # Creates a button tag to be used in a form instead of the default input[type=submit]
      # to help make CSS styling easier
      # 
      # @param [String] value The text for the button
      # @param [Hash] options HTML options to be passed to the button
      # @option [String] icon If included, adds an image to the button to be used as an icon
      # 
      def button(value = nil, options = {})

        value, options = nil, value if value.is_a?(Hash)
        value ||= submit_default_value

        value    = [image_tag(icon, :class => 'icon'), value].join(' ') if icon = options.delete(:icon)
        klasses = (options.delete(:class) || "").split(" ")
        klasses << "button"
        options['class'] = klasses.join(" ")
        content_tag(:button, value.to_s.html_safe, options.reverse_merge!({ "type" => "submit", "name" => "commit" }))

      end
      
      # Overrides fields_for to make sure the form builder is set properly
      # 
      def fields_for(record_or_name_or_array, *args, &block) #:nodoc:
        opts = args.extract_options!
        args.push(opts)
        super(record_or_name_or_array, *args, &block)
      end
      

      ##
      # 
      # Generate a select tag with the 50 US states as options
      # 
      # @param [Symbol] method The object method/attribute to be used
      # @param [Hash] options Same as Rails' select options hash
      # @option options [Symbol] :international Include an international option
      # @option options [Symbol] :abbreviate Use an abbreviated version of the state name for the value
      # @param [Hash] html_options Same as Rails' html_options hash
      # 
      # @return [String] HTML select tag
      # 
      def state_select(method, options = {}, html_options = {})
        abbr = options.delete(:abbreviate)
        abbr = !(abbr.nil? || abbr === false)
        select(method, @template.options_for_select(options_for_state_select(abbr, options.delete(:international)), @object.try(:state)), options, html_options)        
      end

      protected

      ##
      # 
      # Returns a list of US states as an array
      # 
      # @param [Boolean] abbreviate Abbreviate the value
      # @param [Boolean, String] incl_international Include an additional state for "International"
      # 
      # @return [Array] An array of states
      # 
      def options_for_state_select(abbreviate = false, incl_international = false)
        incl_international ||= false
        state_list = [
            ['Alabama', "AL"],['Alaska', "AK"],['Arizona', "AZ"],['Arkansas', "AR"],['California', "CA"],['Colorado', "CO"],
          	['Connecticut', "CT"],['District of Columbia', "DC"],['Delaware', "DE"],['Florida', "FL"],['Georgia', "GA"],
          	['Hawaii', "HI"],['Idaho', "ID"],['Illinois', "IL"],['Indiana', "IN"],['Iowa', "IA"],['Kansas', "KS"],['Kentucky', "KY"],
          	['Louisiana', "LA"],['Maine', "ME"],['Maryland', "MD"],['Massachusetts', "MA"],['Michigan', "MI"],['Minnesota', "MN"],
          	['Mississippi', "MS"],['Missouri', "MO"],['Montana', "MT"],['Nebraska', "NE"],['Nevada', "NV"],['New Hampshire', "NH"],
          	['New Jersey', "NJ"],['New Mexico', "NM"],['New York', "NY"],['North Carolina', "NC"],['North Dakota', "ND"],
          	['Ohio', "OH"],['Oklahoma', "OK"],['Oregon', "OR"],['Pennsylvania', "PA"],['Rhode Island', "RI"],['South Carolina', "SC"],
          	['South Dakota', "SD"],['Tennessee', "TN"],['Texas', "TX"],['Utah', "UT"],['Vermont', "VT"],['Virginia', "VA"],['Washington', "WA"],
          	['West Virginia', "WV"],['Wisconsin', "WI"],['Wyoming', "WY"]

        ].map do |state|
          (abbreviate ? state : [state.first, state.first])
        end
        state_list << ['International', incl_international] unless incl_international === false
        state_list
      end
            
      ##
      # 
      # Checks to see if a particular attribute is required, if so, a "required" attribute is added to the field.
      # 
      # @param [Symbol] attribute The attribute to check against validators
      # @return [Boolean]
      # 
      def attribute_required?(attribute)
        validates_presence?(attribute) || validates_inclusion?(attribute)
      end
      
      # Convenience method to use the +content_tag+ method from our template
      # 
      def content_tag(tag, content, options = {}, escape = true, &block) #:nodoc:
        @template.content_tag(tag, content, options, escape, &block)
      end
      
      ##
      # Checks to see if there are errors for the particular method or attribute
      # 
      # @param [Symbol] method The method/attribute to check
      # 
      # @return [Boolean]
      #
      def errors_on_attribute?(method)
        return false if @object.nil?
        !(@object.errors.empty? || !@object.errors[method.to_sym].present? || [@object.errors[method.to_sym]].flatten.empty?)
      end
      
      ##
      # 
      # Checks a passed validator to see if it is required
      # 'borrowed' from Formtastic by Justin French (see https://github.com/justinfrench/formtastic)
      # 
      # @param [Hash] options Validator options
      # 
      def options_require_validation?(options)
        
        allow_blank = options[:allow_blank]
        return !allow_blank unless allow_blank.nil?
        if_condition = !options[:if].nil?
        condition = if_condition ? options[:if] : options[:unless]

        condition = if condition.respond_to?(:call)
          condition.call(@object)
        elsif condition.is_a?(::Symbol) && @object.respond_to?(condition)
          @object.send(condition)
        else
          condition
        end
        if_condition ? !!condition : !condition
      end
      
      ##
      # 
      # Checks an options hash to determine if a required method/attribute was overridden manually
      # @param [Hash] options The options hash to check
      #
      #
      def required_by_option?(options)
        req = (options.is_a?(Hash) ? options.stringify_keys[:required] : options)
        !(req.to_s === 'false' || req.nil?)
      end
      
      ##
      # 
      # Wrapper method used by all form fields to customize the output
      # 
      # @param [Symbol] helper_method Original Rails helper method name
      # @param [Symbol] method Object method / symbol used for the element
      # @param [Array] args Array of original arguments passed to the helper
      # 
      # @return [String] Rendered HTML tag for the element
      # 
      def render_field_as_custom(helper_method, method, *args)

        @current_field_type = helper_method
        
        options = args.extract_options!
        (@field_order ||= []) << method
        
        # Add an error class to the field if it has errors
        #
        if errors_on_attribute?(method)
          klasses = (options.delete(:class) || "").split(" ")
          klasses << "field_with_errors"
          options[:class] = klasses.join(" ")
        end
        
        # Add a required attribute to the field if it is required
        # Skip if false was passed as the required option
        # 
        options[:required] = "required" if attribute_required?(method) && options.delete(:required).to_s !=  'false'
        options['data-validates-uniqueness'] = "true" if validates_uniqueness?(method)
        
        result   = send(:"_super_#{helper_method}", method, *(args << options))
        messages = @object.nil? ? [] : @object.errors[method]
        render_field_with_errors(method, result, messages)
        
      end
      
      ##
      # 
      # Renders the passed +html_tag+ with the custom error_template
      # 
      # @param [Symbol] method The method/attribute to check for errors
      # @param [Object, String] html_tag Instance of an input tag or a string
      # @param [Array] messages An array of all error messages to be added to the template
      # 
      def render_field_with_errors(method, html_tag, messages)
        
        return html_tag unless errors_on_attribute?(method)
        
        error_class         = 'field_with_errors'
        message_error_class = 'errors_for_field'
        render_binding      = binding
        error_template      = %{
              <span class="<%= error_class %>">
                   <%= html_tag %>
                   <span class="<%= message_error_class %>"><%= [messages].flatten.join(",") %></span>
              </span>}
              
        renderer = ERB.new(error_template)
        renderer.result(render_binding).to_s.html_safe        
      end
      
      ##
      # 
      # Compiles an array of all validators for a particular attribute
      # @param [Symbol] attribtue The attribute to check
      # 
      def validators_for(attribute)
        
        return [] if @object.nil?
        return [] unless @object.class.respond_to?(:validators_on)
        
        attribute  = attribute.to_s.sub(/_id$/, '').to_sym
        @object.class.validators_on(attribute).uniq
        
      end
      
      ##
      # 
      # Convenience method to see if a particular attribute has validators
      # @param [Symbol] attribute The attribute to check
      # 
      def validators_for?(attribute)
        !validators_for(attribute).empty?
      end
      
      ##
      # 
      # Checks for a presence validation on a particular attribute
      # @param [Symbol] attribute The attribute to check
      # 
      def validates_presence?(attribute)
        validator_of_type_exists?(validators_for(attribute), :presence)
      end
      
      ##
      # 
      # Checks for a uniqueness validation on a particular attribute
      # @param [Symbol] attribute The attribute to check
      # 
      def validates_uniqueness?(attribute)
        validator_of_type_exists?(validators_for(attribute), :uniqueness, false)
      end
      
      ##
      # 
      # Checks for inclusion validation on a particular attribute
      # @param [Symbol] attribute The attribute to check
      # 
      def validates_inclusion?(attribute)
        validator_of_type_exists?(validators_for(attribute), :inclusion)
      end
      
      private
      
      def validator_of_type_exists?(validators, kind, check_options = true) #:nodoc: @private
        validators.detect do |validator| 
          exists = (validator.kind.to_s == kind.to_s)
          next exists unless (check_options && exists) && validator.options.present?
          options_require_validation?(validator.options)
        end
      end
      
    end
    
  end
end