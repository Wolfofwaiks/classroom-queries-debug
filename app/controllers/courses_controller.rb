class CoursesController < ApplicationController
  def index
    @courses = Course.all.order({ :created_at => :desc })
    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @course = Course.where({:id => the_id }).at(0)
    render({ :template => "courses/show" })
  end

  def create
    @course = Course.new
    @course.title = params.fetch("query_title")
    @course.term_offered = params.fetch("query_term_offered")
    @course.department_id = params.fetch("query_department_id")

    if @course.valid?
      @course.save
      redirect_to("/courses", { :notice => "Course created successfully." })
    else
      redirect_to("/courses", { :alert => "Course failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @course = Course.where({ :id => the_id }).at(0)

    if @course.present?
      @course.title = params.fetch("query_title")
      @course.term_offered = params.fetch("query_term_offered")
      @course.department_id = params.fetch("query_department_id")

      if @course.valid?
        @course.save
        redirect_to("/courses/#{@course.id}", { :notice => "Course updated successfully." })
      else
        redirect_to("/courses/#{@course.id}", { :alert => "Course failed to update successfully." })
      end
    else
      redirect_to("/courses", { :alert => "Course not found." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @course = Course.where({ :id => the_id }).at(0)

    if @course.present?
      @course.destroy
      redirect_to("/courses", { :notice => "Course deleted successfully." })
    else
      redirect_to("/courses", { :alert => "Course not found." })
    end
  end
end
