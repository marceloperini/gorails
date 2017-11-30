class AddFieldToRegistrationsPresence < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :presence, :boolean, default: false
  end
end
