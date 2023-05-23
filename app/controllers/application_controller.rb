class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  def index
    head 200
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |email, password|
      User.find_by(email:)&.authenticate(password)
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
