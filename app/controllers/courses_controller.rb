class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:watch,:new,:create, :view, :watch_lesson]
  before_action :find_course, only:[:show, :edit, :update, :destroy, :watch_lesson]
  def index
    @courses = Course.all
    render :index, layout: "dashboard"
  end

  def show
    @course = Course.find(params[:id])
    render :show
  end

  def new
    @course = Course.new
    1.times do
      section = @course.sections.build
      1.times do
        section.lessons.build
      end
    end
  end

  def create
    binding.irb
    @course = Course.new(course_params)
    @course.instructor = current_user
    if @course.save
      redirect_to instructor_courses_path, notice: "Course successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    binding.irb
    if @course.update(course_params)
      redirect_to instructor_courses_path, notice: "Course successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @course.destroy
      redirect_to instructor_courses_path, notice: "Course successfully deleted"
    end

  end

  def watch_lesson
    @lesson = Lesson.find(params[:lesson_id])
    
    # Check if user is instructor of this course
    if current_user == @course.instructor
      @enrollment = nil # No enrollment needed for instructor
    else
      @enrollment = Enrollment.find_or_create_by(user: current_user, course: @course)
      
      # Update or create lesson progress for students
      lesson_progress = @enrollment.lesson_progresses.find_or_initialize_by(
        lesson: @lesson, 
        section: @lesson.section
      )
      lesson_progress.status = :in_progress if lesson_progress.status.nil? || lesson_progress.status == 'not_started'
      lesson_progress.save
    end
    
    render :watch
  end

  def view
    @course = current_user.courses.find(params[:id])
    @lesson = @course.sections.first.lessons.first
    render :watch
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, sections_attributes: [:id, :title, :position, lessons_attributes: [:id, :title, :content, :video] ]  )
  end

  def find_course
    @course = Course.find(params[:id])
  end

end
