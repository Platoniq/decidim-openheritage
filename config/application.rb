# frozen_string_literal: true

require_relative "boot"

require "decidim/rails"
require "action_cable/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DecidimOpenheritage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.autoloader = :zeitwerk
    config.load_defaults 7.2
    config.time_zone = "Europe/Amsterdam"

    # Rails 7.1 removed Rails.application.secrets, which this app still reads.
    # Defined here rather than in an initializer because config/environments
    # reads secrets during bootstrap, before initializers run.
    def secrets
      @secrets ||= ActiveSupport::OrderedOptions.new.merge(
        config_for(:secrets).deep_symbolize_keys
      )
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
