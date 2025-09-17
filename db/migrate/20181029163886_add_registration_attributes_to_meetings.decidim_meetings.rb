# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20170810120836)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class AddRegistrationAttributesToMeetings < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_meetings_meetings, :registrations_enabled, :boolean, null: false, default: false
    add_column :decidim_meetings_meetings, :available_slots, :integer, null: false, default: 0
    add_column :decidim_meetings_meetings, :registration_terms, :jsonb
  end
end
