class StylesheetsController < ActionController::Base
  # Serves the legacy compiled stylesheet used by the static marketing pages.
  STYLESHEET_PATH = Rails.root.join("app/assets/stylesheets/application.css").freeze

  # Streams the CSS file directly, caching it for an hour, and logs a helpful
  # warning if the asset is missing from disk.
  def application
    unless File.file?(STYLESHEET_PATH)
      Rails.logger.warn("Legacy stylesheet requested but #{STYLESHEET_PATH} is missing")
      return head :not_found
    end

    expires_in 1.hour, public: true
    send_file STYLESHEET_PATH, type: "text/css", disposition: "inline"
  end
end
