class EmployeesOnsiteController < ApplicationController
  
  def index
    @employees = Employee.all 
  end
  
  def create
    employee = Employee,find(params[:user_id])
    project = Project.find(params[:project_id])

    project.employees << employee
  end
end
