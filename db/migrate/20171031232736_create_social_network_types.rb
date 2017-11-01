class CreateSocialNetworkTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :social_network_types do |t|
      t.string :name_social_media
      t.timestamps
    end
  end
end
