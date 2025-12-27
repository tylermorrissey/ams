require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.enabled = true
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{1.year.to_i}" }
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.active_record.dump_schema_after_migration = false
end
