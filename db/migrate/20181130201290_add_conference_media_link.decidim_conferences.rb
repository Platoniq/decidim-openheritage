# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20181015100301)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:32 UTC
class AddConferenceMediaLink < ActiveRecord::Migration[5.2]
  def change
    create_table :decidim_conferences_media_links do |t|
      t.references :decidim_conference, index: true
      t.jsonb :title, null: false
      t.string :link, null: false
      t.date :date
      t.integer :weight, null: false, default: 0

      t.timestamps
    end
  end
end
