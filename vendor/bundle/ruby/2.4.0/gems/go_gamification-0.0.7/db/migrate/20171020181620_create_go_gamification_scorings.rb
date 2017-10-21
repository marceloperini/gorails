class CreateGoGamificationScorings < ActiveRecord::Migration[5.1]
  def change
    create_table :go_gamification_scorings do |t|
      t.references :task,index: {:name => "index_game_scoring_on_tasks"}
      t.references :subjectable, polymorphic: true,index: {:name => "index_game_scoring_on_subjectable"}

      t.timestamps
    end
    add_index :go_gamification_scorings, [:subjectable_id, :subjectable_type], name: 'index_go_game_score_on_subjectable'
  end
end
