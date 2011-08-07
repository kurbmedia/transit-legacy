##
# Topics are a method of grouping posts by a common name/categorization.
# Topics can be global, or can be based on a particular post class/subclass. 
# 
# @example A global topic
# topic = Topic.create(title: 'Awesome posts')
# 
# @example A topic which only applies to posts of class 'Blog'
# topic = Topic.create(title: 'Awesome posts', post_types: ['Blog'])
# 
# 
class Topic
  include Mongoid::Document
  
  field :title,       :type => String
  field :slug,        :type => String
  field :post_types,  :type => Array
  
  slug_with :title, :before_create
  
  validates :title, :presence => true
  scope :for_type, lambda{ |type| where(:post_types => type) }
  scope :for_editing, lambda{ |klass, inst| ascending(:title) }
  
end
