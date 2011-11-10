module Transit
  module Social
    VERSION = "0.0.1"
  end
end

module Transit
  module Definition
    autoload :Comment, 'transit/definition/comment/base'
  end
end

module Transit
  module Plugin
    autoload :Comments, 'transit/plugin/comments'
  end
end

require 'transit/social/railtie'