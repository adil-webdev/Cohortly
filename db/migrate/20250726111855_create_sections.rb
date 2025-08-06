class CreateSections < ActiveRecord::Migration[8.0]
  def change
    create_table :sections do |t|
      t.references :course
      t.integer :position, null: false, default: 1
      t.string  :title
      t.timestamps
    end
  end
end
