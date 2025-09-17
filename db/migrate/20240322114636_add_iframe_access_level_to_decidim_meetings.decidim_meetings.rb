# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20210903143040)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class AddIframeAccessLevelToDecidimMeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_meetings_meetings, :iframe_access_level, :integer, default: 0
  end
end
