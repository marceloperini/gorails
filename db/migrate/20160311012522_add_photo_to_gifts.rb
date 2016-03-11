class AddPhotoToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :photo, :string
  end
end
