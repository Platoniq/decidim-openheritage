# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20170410073742)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:34 UTC
class RemoveNotNullReferenceProposals < ActiveRecord::Migration[5.0]
  def change
    change_column_null :decidim_proposals_proposals, :reference, true
  end
end
