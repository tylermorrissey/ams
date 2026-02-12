class AssignmentsController < ApplicationController

  def create 
    @assignment = Assignment.new(assignment_params)

    if @assignment.save
      redirect_to @assignment, notice: "Assignment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private 
  def assignment_params
    params.require(:assignments).permit(:employee_id, :project_id, :hours_onsite)
  end
end
