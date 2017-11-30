class CreatePartners < ActiveRecord::Migration[5.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :link
      t.integer :order
      t.boolean :site
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
