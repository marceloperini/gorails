class AddFieldToRegistrationsCertifiedCode < ActiveRecord::Migration[5.1]
  def change
    add_column :registrations, :certified_code, :string
  end
end
