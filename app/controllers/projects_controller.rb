class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.save!
  end

  def new
    @project = Project.new
  end
  
  def index
    @projects = Project.all
  end

  #all projects dashboard
  def project_index
    @project = Project.all[:id]
  end

  #individual project 
  def show
    Project.find(:id)
  end

private 
  def project_params
    params.require(:project).permit(:customer_name, :date, :address, :desc, :job_type, 
                                    :estimates, :net_cost, :employees, :materials, :hours_onsite, 
                                    :equipment_onsite)
  end
end
