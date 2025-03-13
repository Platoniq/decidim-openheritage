# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.28.0"

gem "decidim", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
# gem "decidim-consultations", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-alternative_landing", git: "https://github.com/Platoniq/decidim-module-alternative_landing", branch: "release/0.28-stable"
# gem "decidim-comparative_stats", git: "https://github.com/Platoniq/decidim-module-comparative_stats"
gem "decidim-decidim_awesome", "~> 0.11.4"
gem "decidim-direct_verifications", git: "https://github.com/Platoniq/decidim-verifications-direct_verifications", branch: "main"
gem "decidim-navigation_maps", git: "https://github.com/Platoniq/decidim-module-navigation_maps.git", ref: "7fd50e1368bae4c7955c0ba8ec5ee395273a5329"
gem "decidim-notify", git: "https://github.com/Platoniq/decidim-module-notify", branch: "main"
gem "decidim-superspaces", git: "https://github.com/Platoniq/decidim-superspace", branch: "main"
gem "decidim-term_customizer", git: "https://github.com/mainio/decidim-module-term_customizer", branch: "main"
gem "decidim-time_tracker", git: "https://github.com/Platoniq/decidim-module-time_tracker", branch: "main"

gem "bootsnap", "~> 1.4"
gem "health_check"
gem "sentry-rails"
gem "sentry-ruby"

gem "wicked_pdf", "~> 2.1"

gem "puma"
gem "uglifier", "~> 4.1"

gem "faker"
gem "rspec", "~> 3.10"
gem "rubocop-faker"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 4.0"
  gem "spring-watcher-listen", "~> 2.1"
  gem "web-console", "~> 3.5"

  gem "capistrano", "~> 3.14"
  gem "capistrano-bundler"
  gem "capistrano-passenger"
  gem "capistrano-rails"
  gem "capistrano-rails-console"
  gem "capistrano-rbenv"
  gem "capistrano-sidekiq"
end

group :production do
  gem "aws-sdk-s3", require: false
  gem "figaro", "~> 1.2"
  gem "fog-aws"
  gem "redis", "~> 4.8"
  gem "sidekiq", "~> 6.0"
  gem "sidekiq-cron"
end
