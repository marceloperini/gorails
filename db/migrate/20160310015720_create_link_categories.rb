class CreateLinkCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :link_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
