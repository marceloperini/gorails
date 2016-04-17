class AddNeedCertificateToEvent < ActiveRecord::Migration
  def change
    add_column :users, :need_certificate, :boolean
    add_column :users, :digital_certificate, :boolean
    add_column :users, :printed_certificate, :boolean
  end
end
