class AddPhotoToGifts < ActiveRecord::Migration[5.1]
  def change
    add_column :gifts, :photo, :string
  end
end
