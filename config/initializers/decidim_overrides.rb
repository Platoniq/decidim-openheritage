# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::ParticipatoryProcess.include(Decidim::ParticipatoryProcessOverride)
end
