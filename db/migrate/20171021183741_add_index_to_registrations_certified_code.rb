class AddIndexToRegistrationsCertifiedCode < ActiveRecord::Migration[5.1]
  def change
    add_index :registrations, :certified_code, unique: true
  end
end
