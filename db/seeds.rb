# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Course.create(title: "web development", description: "a beautiful course")
#
#
# Enrollment.create(user_id: 1, course_id: 1, status: :active)

puts "Seeding Cohortly Phase 0..."

# === USERS ===

student1 = User.create(firstname: "adil", lastname: "farooq", age: "20", gender: "male", email: "adil@gmail.com", password: "adilfarooq", role: "student")
instructor = User.create(firstname: "hamza", lastname: "farooq", age: "27", gender: "male", email: "hamza@gmail.com", password: "hamzafarooq", role: "instructor")
admin = User.create(firstname: "hassan", lastname: "farooq", age: "26", gender: "male", email: "hassan@gmail.com", password: "hassanfarooq", role: "admin")
student2 = User.create(firstname: "hamid", lastname: "farooq", age: "40", gender: "male", email: "hamid@gmail.com", password: "hamidfarooq", role: "student")

# # === COURSES ===
course1 = Course.create!(title: "Intro to Ruby", description: "Learn the basics of Ruby programming.", instructor: instructor)
course2 = Course.create!(title: "Advanced Rails", description: "Deep dive into Rails framework.", instructor: instructor)

# # === SECTIONS & LESSONS ===
section1 = course1.sections.create!(title: "Ruby Basics", position: 1)
section2 = course1.sections.create!(title: "Control Structures", position: 2)
#
section1.lessons.create!([
                           { title: "Introduction to Ruby", content: "Variables, types, and syntax.", position: 1 },
                           { title: "Methods in Ruby", content: "Defining and calling methods.", position: 2 },
                         ])

section2.lessons.create!([
                           { title: "If/Else Statements", content: "Flow control with conditionals.", position: 1 },
                           { title: "Loops", content: "Using while and each loops.", position: 2 }
                         ])

# === ENROLLMENTS ===
enrollment1 = Enrollment.create!(student: student1, course: course1)
enrollment2 = Enrollment.create!(student: student2, course: course1)
#
# # === LESSON PROGRESS ===
# # Assuming LessonProgress model has lesson_id, enrollment_id, status
LessonProgress.create!(enrollment: enrollment1, lesson: section1.lessons.first, status: "completed", section: section1)
LessonProgress.create!(enrollment: enrollment1, lesson: section2.lessons.second, status: "in_progress", section: section2)
LessonProgress.create!(enrollment: enrollment2, lesson: section2.lessons.first, status: "not_started", section: section2)

puts "✅ Seeding done!"

