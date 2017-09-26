class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :album, index: true, foreign_key: true
      t.string :asset
      t.string :title

      t.timestamps null: false
    end
  end
end
