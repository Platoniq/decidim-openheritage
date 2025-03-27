# This migration comes from decidim_superspaces (originally 20241119141836)
class CreateDecidimSuperspaces < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_superspaces_superspaces do |t|
      t.references :decidim_organization, null: false, index: { name: "index_decidim_superspaces_superspaces_on_decidim_organization" }
      t.jsonb :title
      t.string :locale

      t.timestamps
    end
  end
end
