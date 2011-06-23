module Transit
  module Builders
    class JstBuilder < Tilt::Template
      
      self.default_mime_type = 'application/javascript'
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)
        <<-JST
        (function() {
          try{
              transit.addTemplate(#{scope.logical_path.inspect}, "#{sanitize_js(data)}");
            }catch(e){};
          }).call();
        JST
      end

      private
      
      def sanitize_js(string)
        js_map = {
          '\\'    => '\\\\',
          '</'    => '<\/',
          "\r\n"  => '\n',
          "\n"    => '\n',
          "\r"    => '\n',
          '"'     => '\\"',
          "'"     => "\\'" 
        }                
        string.gsub(/$(.)/m, "\\1  ").strip.gsub(/(\\|<\/|\r\n|[\n\r"'])/) { |match| js_map[match] }
      end
      
    end
    
  end
end