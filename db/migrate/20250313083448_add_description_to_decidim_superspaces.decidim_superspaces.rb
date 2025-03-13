# This migration comes from decidim_superspaces (originally 20250211124922)
class AddDescriptionToDecidimSuperspaces < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_superspaces_superspaces, :description, :jsonb
  end
end
