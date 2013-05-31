module ErrorsHelper
	module RescueError

	  def self.included(base)	  	
      	base.rescue_from ActiveRecord::RecordNotFound do |e|
      		log_error(e)
        	render "public/404", :status => 404
      	end
      	base.rescue_from ActiveRecord::StatementInvalid do |e|
      		log_error(e)
        	render "public/422", :status => 422
      	end
      	base.rescue_from ActionController::RoutingError do |e|      		
      		log_error(e)
        	render "public/404", :status => 404
      	end      
      	base.rescue_from ActionController::UnknownController do |e|
      		log_error(e)
        	render "public/404", :status => 404
      	end
      	base.rescue_from ActionController::UnknownAction do |e|
      		log_error(e)
        	render "public/404", :status => 404
      	end
      	base.rescue_from NoMethodError do |e|
      		log_error(e)
        	render "public/404", :status => 404
      	end
      end

      protected

      def log_error(exception)
      	Rails.logger.error "[JOBS] Exception #{exception.class}: #{exception.message}"
      end

    end
end
