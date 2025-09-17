# frozen_string_literal: true

# This migration comes from decidim_admin (originally 20170714083651)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:32 UTC
class RenameParticipatoryProcessUserRolesTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :decidim_admin_participatory_process_user_roles, :decidim_participatory_process_user_roles
  end
end
