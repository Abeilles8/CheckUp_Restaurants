class ApplicationController < ActionController::Base
  # before_action :admin_login_check
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  def after_sign_in_path_for(resouce)
    case resouce
      # ログインした人によってリダイレクト先を変える
      when Admin
        admin_path
      when User
        root_path
    end
  end
  
  def authenticate_user
    if @current_user == nil
      redirect_to root_path
    end
  end
  
  
  
  private
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
  end
  
 
  
end
