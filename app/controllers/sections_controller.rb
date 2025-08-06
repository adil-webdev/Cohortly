class SectionsController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @sections = @course.sections
  end

end
