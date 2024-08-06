# frozen_string_literal: true

if ENV["SENTRY_DSN"]
  Sentry.init do |config|
    config.dsn = ENV.fetch("SENTRY_DSN", nil)
    config.breadcrumbs_logger = [:active_support_logger]
    config.traces_sample_rate = 0.5
  end
end
