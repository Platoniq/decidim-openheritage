# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20170123151650)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class AddLatitudeAndLongitudeToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_meetings_meetings, :latitude, :float
    add_column :decidim_meetings_meetings, :longitude, :float
  end
end
