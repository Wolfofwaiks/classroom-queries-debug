class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order({ :created_at => :desc })
    render({ :template => "departments/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @department = Department.where({:id => the_id }).at(0)
    render({ :template => "departments/show" })
  end

  def create
    @department = Department.new
    @department.name = params.fetch("query_name")

    if @department.valid?
      @department.save
      redirect_to("/departments", { :notice => "Department created successfully." })
    else
      redirect_to("/departments", { :alert => "Department failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    if @department.present?
      @department.name = params.fetch("query_name")

      if @department.valid?
        @department.save
        redirect_to("/departments/#{@department.id}", { :notice => "Department updated successfully." })
      else
        redirect_to("/departments/#{@department.id}", { :alert => "Department failed to update successfully." })
      end
    else
      redirect_to("/departments", { :alert => "Department not found." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    if @department.present?
      @department.destroy
      redirect_to("/departments", { :notice => "Department deleted successfully." })
    else
      redirect_to("/departments", { :alert => "Department not found." })
    end
  end
end
