class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.text :local
      t.integer :participants_limit

      t.timestamps null: false
    end
  end
end
