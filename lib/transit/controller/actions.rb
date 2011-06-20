module Transit
  module Controller
    ##
    # Default actions for package based controllers
    # 
    module Actions
      extend ActiveSupport::Concern
      
      included do
        include Transit::Controller::Helpers
      end
      
      def index
        @resources = scope_class.all
        set_instance_var(@resources)
        respond_with(get_instance_var) do |format|
          format.js{ render :partial => 'table' }
          format.any
        end
      end

      def show
        @resource = scope_class.find(params[:id])
        set_instance_var(@resource)
        respond_with(get_instance_var)
      end

      def new
        @resource = scope_class.new
        set_instance_var(@resource)
        respond_with(get_instance_var)
      end

      def create
        @resource = scope_class.new(params["#{scope_name}"])
        unless @resource.save
          flash.now[:error] = "Oops! Looks like you missed a couple fields."
          render :action => :new and return
        end
        set_instance_var(@resource)
        flash[:success] = "Your #{scope_name.to_s.singularize} has been created."
        respond_with(get_instance_var, :location => edit_polymorphic_path(@resource))    
      end

      def edit
        @resource = scope_class.find(params[:id])
        set_instance_var(@resource)
        respond_with(@resource)
      end

      def update
        @resource = scope_class.find(params[:id])
        unless @resource.update_attributes(params["#{scope_name}"])
          flash.now[:error] = "Looks like you were missing a few fields!"
          render :action => :edit and return
        end    
        flash[:success] = "Your #{scope_name.to_s.singularize} has been updated."
        set_instance_var(@resource)
        respond_with(get_instance_var, :location => edit_polymorphic_path(@resource))    
      end

      def destroy
        @resource = scope_class.find(params[:id])
        @resource.destroy
        set_instance_var(@resource)
        flash[:success] = "Your #{scope_name.to_s.singularize} has been deleted."
        respond_with(get_instance_var)
      end
    end
  end
end