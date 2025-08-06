class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :section
      t.integer :position, null: false, default: 1
      t.string  :title
      t.text    :content
      t.timestamps
    end
  end
end
