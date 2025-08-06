class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    course = Course.find_by(id: params[:course_id])
    current_user.enrollments.create!(course: course)
    redirect_to courses_path
  end
end
