module Transit::Definition
  module Comment
    extend ActiveSupport::Concern
    
    included do
      belongs_to :commentable, :polymorphic => true
      belongs_to :user
      validates :body,    :presence => { :allow_blank => false, :message => 'required' }
      validates :user_id, :presence => { :message => 'a user is required' }
      
      after_create  :update_comment_count
      after_destroy :cleanup_comment_count
      delegate :username, :to => :user  

      ::User.send(:has_many, :comments)
    end
    
    module InstanceMethods
      # Stringify the created_at date.
      def timestamp
        self.created_at.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%Y at %I:%M %P")
      end

      private

      ##
      # When created increment a comment_count field on the parent 
      # to avoid parent.comments.count calls and the db overhead.
      # 
      def update_comment_count
        return true unless self.commentable.respond_to?(:comment_count)
        if self.commentable.respond_to?(:inc)
          self.commentable.inc(:comment_count, 1)
        else
          self.commentable.increment(:comment_count)
        end
        true
      end

      ##
      # Inverse of update_comment_count to ensure comment counts are updated on delete/destroy
      # 
      def cleanup_comment_count
        return true unless self.commentable.respond_to?(:comment_count)
        self.commentable.update_attribute(:comment_count, (self.commentable.comment_count - 1))
      end
    end
    
  end
end

Transit::Schema.add(:comment, {
  :body => { :type => String }
})