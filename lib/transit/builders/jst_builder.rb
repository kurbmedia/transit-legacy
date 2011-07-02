module Transit
  module Builders
    class JstBuilder < Tilt::Template
      
      self.default_mime_type = 'application/javascript'
      
      def prepare
      end
      
      def evaluate(scope, locals, &block)        
        pathname = scope.logical_path.inspect
        pathname = pathname.sub("transit/views/", '')
        puts "new builder"   
        <<-JST
        Transit.views[pathname.inspect] = "#{sanitize_js(data)}";
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