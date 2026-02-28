class AssignedToolsController < ApplicationController
  def update
    @assigned_tool = AssignedTool.find(params[:id])

    if @assigned_tool.update(assigned_tool_params)
      redirect_to :assigned_tool, notice: 'Assigned Tools were updated'
    else
      redirect_to :new, status: unprocessable_entity
    end
  end

  private

  def assigned_tool_params
    params.require(:assigned_tool).permit(:project_id, :tool_id, :hours_onsite)
  end
end
