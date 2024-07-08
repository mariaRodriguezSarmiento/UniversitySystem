class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :code
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.references :teacher, null: false, foreign_key: true
      t.references :lounge, null: false, foreign_key: true

      t.timestamps
    end

    create_table :lesson_students do |t|
      t.references :lesson, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.timestamps
    end

    add_index :lesson_students, [:lesson_id, :student_id], unique: true
  end
end
