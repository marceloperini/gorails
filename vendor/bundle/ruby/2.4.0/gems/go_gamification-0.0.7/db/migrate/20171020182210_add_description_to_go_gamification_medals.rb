class AddDescriptionToGoGamificationMedals < ActiveRecord::Migration[5.1]
  def change
     add_column :go_gamification_medals, :description, :text
  end
end
