
require_relative "shared"

Rails.application.configure do
  # Disable CSRF protection in tests (Rails default behavior)
  config.action_controller.allow_forgery_protection = false
end
