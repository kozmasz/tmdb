require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tmdb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # TMDB API KEY
    config.tmdb_api_key      = ENV.fetch('TMDB_API_KEY')
    config.tmdb_bearer_token = ENV.fetch('TMDB_BEARER_TOKEN')

    # values: ["bearer_token", "api_key"]
    config.tmdb_auth_type    = ENV.fetch('TMDB_AUTH_TYPE')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
