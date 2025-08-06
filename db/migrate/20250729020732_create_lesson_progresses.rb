class CreateLessonProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_progresses do |t|
      t.references :enrollment
      t.references :lesson
      t.references :section
      t.integer :status
      t.timestamps
    end
  end
end
