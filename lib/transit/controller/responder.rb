require 'responders'
require 'responders/flash_responder'

module Transit
  module Controller
    class Responder < ActionController::Responder
      
      include Responders::FlashResponder
      Responders::FlashResponder.flash_keys = [:success, :error]
      
      @@flash_keys = [ :success, :error ]
      
      def initialize(controller, resources, options={})
        super
        @flash     = options.delete(:flash)
        @notice    = options.delete(:success)
        @alert     = options.delete(:error)
        @flash_now = options.delete(:flash_now)
      end
      
      def to_js
        if set_flash_message?
          set_flash_message! 
          header_hash = {}
          puts controller.flash.inspect
          controller.flash.each{ |key, value| header_hash.merge!(key => value) }
          controller.response['X-Flash-Messages'] = header_hash.to_json
        end      
        defined?(super) ? super : to_format
      end
      
      protected
      
      def set_flash_message!
        if has_errors?
          set_flash(:error, @alert)
          status = Transit::Controller::Responder.flash_keys.last
        else
          set_flash(:success, @notice)
          status = Transit::Controller::Responder.flash_keys.first
        end

        return if controller.flash[status].present?

        options = mount_i18n_options(status)
        message = ::I18n.t options[:default].shift, options
        set_flash(status, message)
      end
      
    end
  end
end