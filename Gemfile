# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# DECIDIM_VERSION={:path => "../decidim"}
DECIDIM_VERSION={:git => "https://github.com/Platoniq/decidim", :branch => "temp/0.22-surveys"}
NAVIGATION_MAPS={git: "https://github.com/Platoniq/decidim-module-navigation_maps"}
COMPARATIVE_STATS={git: "https://github.com/Platoniq/decidim-module-comparative_stats"}
DECIDIM_AWESOME={git: "https://github.com/Platoniq/decidim-module-decidim_awesome"}

gem "decidim", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-consultations", DECIDIM_VERSION
gem "decidim-navigation_maps", NAVIGATION_MAPS
gem "decidim-comparative_stats", COMPARATIVE_STATS
gem "decidim-decidim_awesome", DECIDIM_AWESOME
# gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-time_tracker", git: "https://github.com/Platoniq/decidim-module-time_tracker"
gem "decidim-term_customizer", git: "https://github.com/Platoniq/decidim-module-term_customizer", branch: "temp/0.22"

gem "decidim-direct_verifications", "~> 0.17"
gem 'redcarpet'
gem "jquery-slick-rails"
gem 'simplemde-rails'

gem "bootsnap", "~> 1.4"

gem "puma", "~> 4.3.3"
gem "uglifier", "~> 4.1"

gem "faker", "~> 1.9"
gem "health_check"
gem "sidekiq", "~> 5.2"
gem "sidekiq-cron"
gem "sentry-raven"
gem "rspec"

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
