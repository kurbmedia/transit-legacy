module Transit::Definition
  module Post
    module Navigation
      
      # Grab the post "previous" to this one, ordered by post date
      # @example
      #   @post.previous_post
      # 
      def previous_post
        @previous_post ||= self.class.only(:title, :slug).where(:post_date.lt => self.post_date).descending(:post_date).first
      end

      # Grab the post "next" to this one, ordered by post date
      # @example
      #   @post.next_post
      #
      def next_post
        @next_post ||= self.class.only(:title, :slug).where(:post_date.gt => self.post_date).ascending(:post_date).first
      end

    end
  end
end