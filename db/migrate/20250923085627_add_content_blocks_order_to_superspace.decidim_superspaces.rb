# This migration comes from decidim_superspaces (originally 20250813130000)
class AddContentBlocksOrderToSuperspace < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_superspaces_superspaces, :content_blocks_order, :text
    remove_column :decidim_superspaces_superspaces, :show_statistics, :boolean
  end
end

