class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cover_photo, :string
    add_column :users, :bio, :text
    add_column :users, :job_title, :string
  end
end
