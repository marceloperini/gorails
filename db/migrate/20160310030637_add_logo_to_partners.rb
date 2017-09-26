class AddLogoToPartners < ActiveRecord::Migration[5.1]
  def change
    add_column :partners, :logo, :string
  end
end
