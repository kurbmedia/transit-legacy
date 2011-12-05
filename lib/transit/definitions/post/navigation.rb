module Transit::Definition
  module Post
    module Navigation
      
      # Grab the post "previous" to this one, ordered by post date
      # @example
      #   @post.previous_post
      # 
      def previous_post
        @previous_post ||= self.class.excludes(:_id => self.id).where(:post_date.lte => self.post_date, :published => true).descending(:post_date).first
      end

      # Grab the post "next" to this one, ordered by post date
      # @example
      #   @post.next_post
      #
      def next_post
        @next_post ||= self.class.excludes(:_id => self.id).where(:post_date.gte => self.post_date, :published => true).ascending(:post_date).first
      end

    end
  end
end