class Asset
  
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :meta, :type => Hash  
  
  has_and_belongs_to_many :packages, polymorphic: true
  
end