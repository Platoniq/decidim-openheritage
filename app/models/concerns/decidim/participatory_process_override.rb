# frozen_string_literal: true

module Decidim
  module ParticipatoryProcessOverride
    extend ActiveSupport::Concern

    included do
      default_scope { order(weight: :asc) }
    end
  end
end
