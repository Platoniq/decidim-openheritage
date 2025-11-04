# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20180125104426)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:32 UTC
class AddReferenceToAssemblies < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_assemblies, :reference, :string
  end
end
