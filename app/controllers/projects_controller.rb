class ProjectsController < ApplicationController
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @project = Project.new
  end

  def index
    @projects = Project.all.includes(:employees, :tools)
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @employees = Employee.all
    @tools = Tool.all

    @tools.each do |tool|
      @project.assigned_tools.find_or_initialize_by(tool_id: tool.id)
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was succesffully deleted.'
  end

  private

  def project_params
    params.require(:project).permit(
      :customer_name,
      :address,
      :desc,
      :job_type,
      :estimates,
      :net_cost,
      :materials,
      :hours_onsite,
      :equipment_onsite,
      :date_started,
      :date_ended,
      :hours_onsite,
      employee_ids: [],
      tool_ids: [],
      assigned_tools: %i[id hours_onsite]
    )
  end
end
