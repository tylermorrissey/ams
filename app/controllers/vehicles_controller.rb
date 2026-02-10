class VehiclesController < ApplicationController
  def hello
  end
  
  def create
    @vehicle = Vehicle.new(params)

    if @vehicle.save
      redirect_to @vehicle
    else
      @vehicle.errors.full_messages
    end
  end
end
