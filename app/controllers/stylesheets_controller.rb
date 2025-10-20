class StylesheetsController < ActionController::Base
  STYLESHEET_PATH = Rails.root.join("app/assets/stylesheets/application.css").freeze

  def application
    unless File.file?(STYLESHEET_PATH)
      Rails.logger.warn("Legacy stylesheet requested but #{STYLESHEET_PATH} is missing")
      return head :not_found
    end

    expires_in 1.hour, public: true
    send_file STYLESHEET_PATH, type: "text/css", disposition: "inline"
  end
end
