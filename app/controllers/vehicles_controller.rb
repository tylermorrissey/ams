class VehiclesController < ApplicationController
  
  def new
    @vehicle = Vehicle.new
  end
  
  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      # redirect_to @vehicle
    else
      @vehicle.errors.full_messages
    end
  end


  private 
  def vehicle_params
    params.require(:vehicle).permit(:model, :year, :nick_name)
  end

end
