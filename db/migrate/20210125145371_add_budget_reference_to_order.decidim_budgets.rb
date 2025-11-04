# frozen_string_literal: true

# This migration comes from decidim_budgets (originally 20200706142609)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-16 15:07:32 UTC
class AddBudgetReferenceToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_budgets_orders, :decidim_budgets_budget, foreign_key: true
  end
end
