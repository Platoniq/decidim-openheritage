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
    config.load_defaults 5.2
    config.time_zone = "Europe/Amsterdam"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
