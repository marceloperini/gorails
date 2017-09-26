class AddCategoryToPartners < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :category, :integer
  end
end
