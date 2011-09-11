module Transit
  class Context
    include Mongoid::Document
    embeds_many :packages, :polymorphic => true
  end
end

module Transit
  class Asset
    include Mongoid::Document
  end
end

