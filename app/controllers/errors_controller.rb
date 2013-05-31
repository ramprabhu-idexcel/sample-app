class ErrorsController < ApplicationController
  def routing  
    raise ActionController::RoutingError.new(params[:path])
  end	
end
