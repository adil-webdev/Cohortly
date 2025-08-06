class DashboardController < ApplicationController
  layout "application"
  before_action :authenticate_user!, only: [:index]
  def index
    case current_user.role
    when "student"
      render 'dashboard/student/index', layout: "dashboard"
    when "instructor"
      render 'dashboard/instructor/index', layout: "dashboard"
    end
  end

  def home
  end

end
