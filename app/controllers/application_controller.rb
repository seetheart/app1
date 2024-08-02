class ApplicationController < ActionController::API
  before_action :authenticate_request, :authorize_request

  private
  def authenticate_request
    @curret_user_role = 'admin'
  end


  def authorize_request
    auth_service = AuthorizeService.new(auth_params)
    res = auth_service.authorize
    if !res
      render json: { message: "Unauthorized"}, status: :forbidden
    end
  end

  def auth_params
    {
      action_name: (params[:action] + '_' + params[:controller]).upcase,
      role_name: @curret_user_role,
      application_name: Rails.application.config.app_name
    }
  end
end
