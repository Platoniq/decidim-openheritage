# frozen_string_literal: true

# This migration comes from decidim_meetings (originally 20170410074252)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class RemoveNotNullReferenceMeetings < ActiveRecord::Migration[5.0]
  def change
    change_column_null :decidim_meetings_meetings, :reference, true
  end
end
