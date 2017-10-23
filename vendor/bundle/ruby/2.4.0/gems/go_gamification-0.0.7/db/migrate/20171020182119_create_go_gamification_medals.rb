class CreateGoGamificationMedals < ActiveRecord::Migration[5.1]
  def change
    create_table :go_gamification_medals do |t|
      t.references :task, index: true
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
