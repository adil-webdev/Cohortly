class InstructorController < ApplicationController
  before_action :authenticate_user!

  def courses
    @courses = current_user.courses
    render 'instructor/courses', layout: 'dashboard'
  end
end
