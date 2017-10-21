class RenameEverything < ActiveRecord::Migration[5.1]
  def change
        rename_table :go_gamification_scorings, :go_gamification_rewards
    rename_column :go_gamification_rewards, :subjectable_id, :rewardable_id
    rename_column :go_gamification_rewards, :subjectable_type, :rewardable_type

    rename_column :go_gamification_tasks, :taskable_id, :rewarding_id
    rename_column :go_gamification_tasks, :taskable_type, :rewarding_type
  end
end
