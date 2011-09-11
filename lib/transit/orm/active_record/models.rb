module Transit
  class Context
    extend ActiveRecord::Base
    has_many :packages, :polymorphic => true
  end
end

Transit::Asset.class_eval do
  extend ActiveRecord::Base
end