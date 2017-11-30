class AlterTableUserChangeState < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :uf
    add_column :users, :geography_state_id, :integer
  end
end
