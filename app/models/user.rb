class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # :confirmable

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :courses, foreign_key: :instructor_id

  enum :role, { student: 1, instructor: 2, admin: 3 }
  enum :gender, { male: 1, female: 2 }


  def enrolled?(course)
    self.enrolled_courses.include?(course)
  end

  def is_the_creator?(course)
    self.courses.include?(course)
  end

end
