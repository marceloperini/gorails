class RenameGoGamificationTasksToGoals < ActiveRecord::Migration[5.1]
  def change
        rename_table :go_gamification_tasks, :go_gamification_goals
    rename_column :go_gamification_rewards, :task_id, :goal_id
    rename_column :go_gamification_medals, :task_id, :goal_id
  end
end
