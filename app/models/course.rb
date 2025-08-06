class Course < ApplicationRecord
  has_many :enrollments
  has_many :students, through: :enrollments
  has_many :sections, dependent: :destroy

  belongs_to :instructor, class_name: "User"

  accepts_nested_attributes_for :sections, allow_destroy: true

  def progress_for_user(user)
    enrollment = enrollments.find_by(user_id: user)
    return 0 unless enrollment

    total_lessons = sections.joins(:lessons).count
    return 0 if total_lessons == 0

    completed_lessons = enrollment.lesson_progresses.where(status: :completed).count
    (completed_lessons.to_f / total_lessons * 100).round
  end

  def total_lessons
    sections.joins(:lessons).count
  end

  # has_many :sections


end