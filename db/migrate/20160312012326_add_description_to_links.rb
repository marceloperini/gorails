class AddDescriptionToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :description, :text
  end
end
