class StudentsController < ApplicationController
  before_action :authenticate_user!
  def enrolled_courses
    @enrolled_courses = current_user.enrolled_courses
    render :enrolled_courses, layout: 'dashboard'
  end


end
