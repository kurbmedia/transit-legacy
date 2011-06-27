require 'responders'
require 'responders/flash_responder'

module Transit
  module Controller
    class Responder < ActionController::Responder
      mattr_accessor :flash_keys
      
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
          controller.flash.each{ |key, value| header_hash.merge!(key => value) }
          controller.response['X-Flash-Messages'] = header_hash.to_json
        end      
        defined?(super) ? super : to_format
      end
      
    end
  end
end