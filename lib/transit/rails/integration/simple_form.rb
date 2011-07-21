require 'simple_form'
# # Configure SimpleForm. Even though most are defaults, enforce them in case
# defaults change later.
# 
SimpleForm.setup do |config|
  config.components   = [ :placeholder, :label_input, :hint, :error ]
  config.hint_tag     = :span
  config.hint_class   = :hint
  config.error_class  = 'error-for-field'
  config.error_tag    = :span
  config.error_method = :first

  config.error_notification_tag   = :span
  config.error_notification_class = 'error-for-field'
  config.wrapper_error_class      = 'field-with-errors'
  config.error_notification_id    = nil

  config.wrapper_tag              = :li
  config.wrapper_class            = :input        
  config.collection_wrapper_tag   = nil
  config.item_wrapper_tag         = :span
  config.collection_label_methods = [ :to_label, :name, :title, :to_s ]
  config.collection_value_methods = [ :id, :to_s ]
  
  config.label_text          = lambda { |label, required| "#{label} #{required}" }
  config.label_class         = nil
  config.form_class          = :simple_form
  config.required_by_default = false
  config.browser_validations = true
  
  config.html5              = true
  config.input_mappings     = { /count/ => :integer }
  config.file_methods       = [ :file? ]
  config.time_zone_priority = 'Eastern Time (US & Canada)'
  config.country_priority   = 'United States'
  config.default_input_size = nil
  config.translate          = true        
end