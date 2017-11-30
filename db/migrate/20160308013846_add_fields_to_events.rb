class AddFieldsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :end_at, :datetime
    rename_column :events, :date, :start_at
  end
end
