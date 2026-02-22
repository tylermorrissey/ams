class ToolsController < ApplicationController
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
    @tools = Tool.all
  end

  def update
    @tool = Tool.find(params[:id])

    if @tool.update(tool_params)
      redirect_to tool_path(@tool)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @tool = Tool.find(params([:id]))
  end

  def edit
    @tool = Tool.find(params([:id]))
    @assignment = Assignment.find(params([:id]))
  end

  def destroy
    @tool = Tool.find(params([:id]))
    @tool.destroy
    redirect_to tools_path notice: 'Tool was successfully deleted.'
  end

  private

  def tool_params
    params.require(:tool).permit(
      :name,
      :make,
      :model,
      :serial_number,
      :purchase_date,
      :project_id
    )
  end
end
