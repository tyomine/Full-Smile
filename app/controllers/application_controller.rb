class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
before_action :unchecked_reports, if: :admin_signed_in?

  def after_sign_out_path_for(resource)
    if resource == :admin
      admin_root_path
    elsif resource == :user
      root_path
    end
  end
  
  def redirect_to_posts_path_if_logged_in
    redirect_to posts_path if user_signed_in?
  end
  
  def unchecked_reports
    @unchecked_reports = Report.where(is_checked:false)
  end  
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
end
