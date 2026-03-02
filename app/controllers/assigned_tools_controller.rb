class AssignedToolsController < ApplicationController
  before_action :set_assigned_tool, only: %i[update destroy]

  def create
    @assigned_tool = AssignedTool.new(assigned_tool_params)

    if @assigned_tool.save
      redirect_to project_path(@assigned_tool.project), notice: 'Tool has been assigned to project'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @assigned_tool.update(assigned_tool_params)
      redirect_to assigned_tool_path(@assigned_tool), notice: 'Assigned Tools were updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @assigned_tool.destroy
    redirect_to assigned_tools_path, notice: 'Tool has been unassigned.'
  end

  private

  def assigned_tool_params
    params.require(:assigned_tool).permit(:project_id, :tool_id, :hours_onsite)
  end

  def set_assigned_tool
    @assigned_tool = AssignedTool.find(params[:id])
  end
end
