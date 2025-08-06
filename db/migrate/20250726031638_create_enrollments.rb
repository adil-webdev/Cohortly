class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
