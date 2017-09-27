class CreateSocialNetworks < ActiveRecord::Migration[5.1]
  def change
    create_table :social_networks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :link

      t.timestamps null: false
    end
  end
end
