class AddSeenAtToGoGamificationRewards < ActiveRecord::Migration[5.1]
  def change
    change_table :go_gamification_rewards do |t|
      t.datetime :seen_at
    end

    add_index :go_gamification_rewards, :seen_at, name: 'index_go_gamification_rewards_on_seen_at'
  end
end
