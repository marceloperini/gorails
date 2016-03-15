class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :album, index: true, foreign_key: true
      t.string :asset
      t.string :title

      t.timestamps null: false
    end
  end
end
