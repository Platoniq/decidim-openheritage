# frozen_string_literal: true

# This migration comes from decidim_initiatives (originally 20190213184301)
# This file has been modified by `decidim upgrade:migrations` task on 2026-08-20 08:53:02 UTC
class AddUndoOnlineSignaturesEnabledToInitiativesTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :undo_online_signatures_enabled, :boolean, null: false, default: true
  end
end
