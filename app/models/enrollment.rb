class Enrollment < ApplicationRecord
  enum :status, {active: 0, completed: 1, dropped: 2}

  belongs_to :course
  belongs_to :student, class_name: "User", foreign_key: "user_id"

  has_many :lesson_progresses
end
