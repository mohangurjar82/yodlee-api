class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :business_name,  :email, :password ])
  end

  def layout_by_resource
    if devise_controller?
      'empty'
    else
      "application"
    end
  end

  def after_sign_in_path_for(resource)
    dashboards_dashboard_1_path
  end

end
