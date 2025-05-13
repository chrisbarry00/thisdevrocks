class ApplicationController < ActionController::API
  before_action :authenticate_api_request

  private

  def authenticate_api_request
    token = request.headers['Authorization']&.split(' ')&.last

    Rails.logger.info "Expected Token: #{ENV['API_AUTH_TOKEN']}"
    Rails.logger.info "Received Token: #{token}"

    if token != ENV['API_AUTH_TOKEN']
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
