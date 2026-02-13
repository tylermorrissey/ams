class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)
    @project.save!

    if @project.valid?
      render :index
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @project = Project.new
  end
  
  def index
    @projects = Project.all
  end

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
