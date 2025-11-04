# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20200320105913)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:32 UTC
class IndexForeignKeysInDecidimConferences < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_conferences, :decidim_scope_id
  end
end
