class LessonProgress < ApplicationRecord
  belongs_to :enrollment
  belongs_to :lesson
  belongs_to :section

  enum :status, { completed: 1, in_progress: 2, not_started: 3 }
end
