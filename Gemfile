# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# DECIDIM_VERSION={:path => "../decidim"}
DECIDIM_VERSION = { git: "https://github.com/Platoniq/decidim", branch: "temp/0.22-surveys" }.freeze
NAVIGATION_MAPS = { git: "https://github.com/Platoniq/decidim-module-navigation_maps" }.freeze
COMPARATIVE_STATS = { git: "https://github.com/Platoniq/decidim-module-comparative_stats" }.freeze

gem "decidim", DECIDIM_VERSION
gem "decidim-comparative_stats", COMPARATIVE_STATS
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-consultations", DECIDIM_VERSION
gem "decidim-decidim_awesome", "~> 0.5.1"
gem "decidim-navigation_maps", NAVIGATION_MAPS
# gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-term_customizer", git: "https://github.com/Platoniq/decidim-module-term_customizer", branch: "temp/0.22"
gem "decidim-time_tracker", git: "https://github.com/Platoniq/decidim-module-time_tracker"

gem "decidim-direct_verifications", "~> 0.22"
gem "jquery-slick-rails"
gem "redcarpet"
gem "simplemde-rails"

gem "bootsnap", "~> 1.4"

gem "puma", "~> 4.3.3"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"
gem "health_check"
gem "rspec"
gem "sentry-raven"
gem "sidekiq", "~> 5.2"
gem "sidekiq-cron"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :production do
  gem "fog-aws"
end
