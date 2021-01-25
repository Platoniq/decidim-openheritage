class RemoveOldTimeTracker < ActiveRecord::Migration[5.2]
  def up
    drop_table(:decidim_time_tracker_events, if_exists: true)
    drop_table(:decidim_time_tracker_assignees, if_exists: true)
    drop_table(:decidim_time_tracker_milestones, if_exists: true)
    drop_table(:decidim_time_tracker_events, if_exists: true)
    drop_table(:decidim_time_tracker_activities, if_exists: true)
    drop_table(:decidim_time_tracker_tasks, if_exists: true)
    drop_table(:decidim_time_trackers, if_exists: true)
  end
end
