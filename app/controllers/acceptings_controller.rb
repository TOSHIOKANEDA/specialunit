class AcceptingsController < ApplicationController
  
  def new
  end
  
  def create
  Accepting.create(accepting_params)
  end
  


  private
  def accepting_params
    params.permit(:place, :kind, :week)
  end

end