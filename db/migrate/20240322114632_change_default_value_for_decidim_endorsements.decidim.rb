# frozen_string_literal: true

# This migration comes from decidim (originally 20231027142329)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class ChangeDefaultValueForDecidimEndorsements < ActiveRecord::Migration[6.1]
  def up
    change_column_default :decidim_endorsements, :decidim_user_group_id, 0
  end

  def down
    change_column_default :decidim_endorsements, :decidim_user_group_id, nil
  end
end
