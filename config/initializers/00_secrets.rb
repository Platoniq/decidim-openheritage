# frozen_string_literal: true

# Rails 7.1 removed Rails.application.secrets, which Decidim 0.31 requires.
# This app reads it in ~118 places, including nested per-host config (matomo
# tenants, menu overrides) that does not map onto flat ENV vars. config/secrets.yml
# already has the shape config_for expects, so keep reading it from there.
Rails.application.singleton_class.prepend(Module.new do
  def secrets
    @secrets ||= ActiveSupport::OrderedOptions.new.merge(
      config_for(:secrets).deep_symbolize_keys
    )
  end
end)
