class Topic
  include Mongoid::Document
  
  field :title,       :type => String
  field :slug,        :type => String
  field :post_types,  :type => Array
  
  validates :title, :presence => true
  before_create :generate_slug
   
  scope :for_type, lambda{ |type| where(:post_types => type) }
  
  def generate_slug
    return true unless self.slug.to_s.blank?
    self.slug = self.title.to_slug
  end
  
end
