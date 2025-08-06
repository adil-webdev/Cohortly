class Section < ApplicationRecord
  has_many :lessons, dependent: :destroy
  belongs_to :course
  has_many :lesson_progresses

  accepts_nested_attributes_for :lessons, allow_destroy: true
end
