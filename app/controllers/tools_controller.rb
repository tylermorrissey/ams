class ToolsController < ApplicationController
  before_action :set_tool, only: %i[show edit update destroy]
  ALLOWED_SORT_COLUMNS = %w[name make model projects.customer_name].freeze
  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      redirect_to tools_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    sort_column = ALLOWED_SORT_COLUMNS.include?(params[:sort]) ? params[:sort] : 'name'
    @tools = Tool.includes(:projects).order(sort_column).distinct
  end

  def update
    if @tool.update(tool_params)
      redirect_to tool_path(@tool)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @assigned_tools = @tool.assigned_tools
  end

  def edit
  end

  def destroy
    @tool.destroy
    redirect_to tools_path, notice: 'Tool was successfully deleted.'
  end

  private

  def tool_params
    params.require(:tool).permit(
      :name,
      :make,
      :model,
      :serial_number,
      :purchase_date
    )
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
