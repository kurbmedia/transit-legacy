module Transit::Model
  module Paginator
    
    module Criteria
      extend ActiveSupport::Concern
      included do
        def page(*args)
          self.klass.page(*args).criteria.merge(self)
        end
      end
    end
    
    module ClassMethods
      
      ##
      # Sets the default number of items per-page. Allows setting the option for 
      # both "admin" / management pages as well as a default for front-end pages.
      # 
      # @example Set a default of 10, with a default of 20 for admin pages
      #   per_page 10, admin: 20
      # 
      # @example Set a global default of 10
      #   per_page 10
      # 
      def deliver_per_page(*opts)
        options = opts.extract_options!
        if options.empty?
          pagination_options.merge!(default: opts.first, admin: opts.first)
        else
          pagination_options.merge!(options)
        end
        unless opts.empty?
          pagination_options.merge!(default: opts.first) unless opts.first.nil?
        end
      end
      
      def pagination_options
        @_pagination_options ||= { default: 10, admin: 20 }
      end
      
    end
    
    module Document
      extend ActiveSupport::Concern
      
      included do
        ##
        # Retrieve a page of items, with an optional `per` value representing the number of items per page.
        # 
        # @example Retrieve Posts 11-20
        #   Post.page(2, per: 10)
        #
        scope :page, Proc.new { |*opts|
          options       = opts.extract_options!
          show_per_page = options.delete(:per) || pagination_options[:default]
          current_index = (opts.first.to_i || 1)
          limit(show_per_page).offset(show_per_page * ([current_index.to_i, 1].max - 1))
        } do
          include Transit::Model::Paginator::Scoping
        end
        
        # Add an 'admin' scope method for convenience.
        # 
        scope :admin_page, lambda{ |pg| page(pg, pagination_options[:admin]) }
        
      end  
    end 
    
    module Scoping
      def total_count #:nodoc:
        count
      end      
      # Total number of pages
      def total_pages
        (total_count.to_f / options[:limit]).ceil
      end
      # Current page number
      def current_page
        (options[:skip] / options[:limit]) + 1
      end
      # First page of the collection ?
      def first_page?
        current_page == 1
      end
      # Last page of the collection?
      def last_page?
        current_page >= num_pages
      end
    end   
    
  end
end