class User
  if ENV['TRANSIT_ORM'] == "mongoid"
    include Mongoid::Document
    include Mongoid::Timestamps
  end
  
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_accessor :first_name, :last_name, :email, :information, :required_item, :included_item, :unique_item, :state
  
  validates :required_item, :presence => true
  validates :included_item, :inclusion => { :in => 'test' }
  
  def initialize(attrs = {})
    attrs.each_pair{ |k, v| instance_variable_set("@#{k}".to_sym, v) }
  end
  
  def persisted?
    false
  end
  
end