class TimeCardsController < ApplicationController
  def new
    @time_card = TimeCard.new
  end

  def create
    @time_card = TimeCard.create(time_card_params)

    if @time_card.save
      redirect_to @time_card, notice: "Time Card was successfully recorded" 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @time_card = TimeCard.all
  end

  def show
    @time_card = TimeCard.find(:id)
  end

  def edit
    @time_card = TimeCard.find(time_card_params[:id])
  end

  def update
    if @time_card.update(time_card_params[:id])
      redirect_to @time_card, notice: "Time Card was updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @time_card.destroy
    redirect_to time_card_url, notice: "Time Card was successfully deleted."
  end

  private
  def time_card_params
    params.require(:time_card).permit(:clock_in, :clock_out, :project_id, :employee_id)
  end
end
