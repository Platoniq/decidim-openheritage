# This migration comes from decidim_superspaces (originally 20241119142514)
class CreateDecidimSuperspacesParticipatorySpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_superspaces_superspaces_participatory_spaces do |t|
      t.references :decidim_superspaces_superspace, null: false, index: { name: "decidim_superspaces_participatory_space_superspace" }
      t.references :participatory_space, polymorphic: true, index: { name: "decidim_superspaces_participatory_space_participatory_space" }

      t.timestamps
    end
  end
end
