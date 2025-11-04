# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20201006140511)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class AddOnlineMeetingUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_meetings_meetings, :online_meeting_url, :string
  end
end
