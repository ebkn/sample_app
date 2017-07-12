require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
