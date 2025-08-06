class Lesson < ApplicationRecord
  belongs_to :section
  has_many :lesson_progresses
  has_one_attached :video
end
