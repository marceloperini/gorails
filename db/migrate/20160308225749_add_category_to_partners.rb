class AddCategoryToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :category, :integer
  end
end
