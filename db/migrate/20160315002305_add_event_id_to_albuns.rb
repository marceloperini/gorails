class AddEventIdToAlbuns < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :event_id, :integer

  end
end
