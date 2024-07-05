class CreateLounges < ActiveRecord::Migration[7.1]
  def change
    create_table :lounges do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
