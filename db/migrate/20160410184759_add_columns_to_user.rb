class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :celphone, :string
    add_column :users, :schooling, :string
    add_column :users, :birth_date, :date
    add_column :users, :marital_status, :string
    add_column :users, :father, :string
    add_column :users, :mother, :string
    add_column :users, :rg, :string
    add_column :users, :consignor_organ, :string
    add_column :users, :place_of_birth, :string
    add_column :users, :special_needs, :string
    add_column :users, :occupation, :string
    add_column :users, :address, :string
    add_column :users, :uf, :string
    add_column :users, :neighborhood, :string
    add_column :users, :zip_code, :string
    add_column :users, :complement, :string
  end
end
