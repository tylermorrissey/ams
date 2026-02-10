class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.save!
  end

private 
  def project_params
    params.require(:project).permit(:customer_name, :date, :address, :desc, :job_type, 
                                    :estimates, :net_cost, :employees, :materials, :hours_onsite, 
                                    :equipment_onsite)
  end
end
