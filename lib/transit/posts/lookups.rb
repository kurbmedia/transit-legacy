module Transit
  module Posts
    
    module Lookups
      
      # Grab the previous post for a previous > next link list
      def previous_post
        @previous_post ||= self.class.only(:title, :slug).where(:post_date.lt => self.post_date).descending(:post_date).first
      end

      # Grab the next post for a previous > next link list
      def next_post
        @next_post ||= self.class.only(:title, :slug).where(:post_date.gt => self.post_date).ascending(:post_date).first
      end
      
    end
    
  end
end