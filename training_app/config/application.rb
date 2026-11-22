require "bundler/setup"
require "rails"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "securerandom"
require "fileutils"

module TrainingApp
  class Application < Rails::Application
    config.load_defaults 8.1
    config.root = File.expand_path("..", __dir__)
    config.eager_load = false
    config.hosts = ["localhost", "127.0.0.1"]
    config.public_file_server.enabled = true
    config.action_controller.allow_forgery_protection = true
    config.session_store :cookie_store, key: "ojt_day_#{ENV.fetch('TRAINING_DAY', '6')}", same_site: :lax
    secret_path = config.root.join("tmp/development_secret")
    FileUtils.mkdir_p(secret_path.dirname)
    File.write(secret_path, SecureRandom.hex(64), mode: "w", perm: 0o600) unless secret_path.exist?
    config.secret_key_base = ENV.fetch("SECRET_KEY_BASE") { File.read(secret_path) }
  end
end
