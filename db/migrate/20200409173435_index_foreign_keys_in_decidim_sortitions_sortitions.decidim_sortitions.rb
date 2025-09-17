# frozen_string_literal: true

# This migration comes from decidim_sortitions (originally 20200320105926)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:35 UTC
class IndexForeignKeysInDecidimSortitionsSortitions < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_sortitions_sortitions, :cancelled_by_user_id
  end
end
