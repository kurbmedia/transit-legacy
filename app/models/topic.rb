class Topic
  include Mongoid::Document
  
  field :title,       :type => String
  field :slug,        :type => String
  field :post_types,  :type => Array
  
  validates :title, :presence => true
  modded_with :sluggable, :fields => :title, :as => :slug 
  
  references_and_referenced_in_many :posts
  scope :for_type, lambda{ |type| where(:post_types => type) }
  
  
end
