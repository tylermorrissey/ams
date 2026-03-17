class TimeCardsController < ApplicationController
  before_action :set_time_card, only: %i[show edit update destroy]

  def new
    @time_card = TimeCard.new
  end

  def create
    @time_card = TimeCard.new(time_card_params)

    if @time_card.save
      redirect_to @time_card, notice: 'Time Card was successfully recorded'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @time_cards = TimeCard.all
  end

  def show
  end

  def edit
  end

  def update
    if @time_card.update(time_card_params)
      redirect_to @time_card, notice: 'Time Card was updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @time_card.destroy
    redirect_to time_cards_path, notice: 'Time Card was successfully deleted.'
  end

  private

  def set_time_card
    @time_card = TimeCard.find(params[:id])
  end

  def time_card_params
    params.require(:time_card).permit(:clock_in, :clock_out, :date, :project_id, :employee_id)
  end
end
