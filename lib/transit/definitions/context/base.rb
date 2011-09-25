module Transit::Definition
  module Context
    extend ActiveSupport::Concern
    
    included do
      before_create :ensure_context_position
    end
    
    private
    
    ##
    # Contexts are always ordered by position. Before creation, 
    # this method ensures that position is always created in an 
    # incrementing order.
    # 
    def ensure_context_position
      return true unless self.position.nil?
      self.position = self.package.contexts.count
    end
    
  end
end

Transit::Schema.add(:context, {
  :body     => { :type => String, :default => "" },
  :meta     => { :type => Hash, :default => {} },
  :position => { :type => Integer, :default => 0 }
})