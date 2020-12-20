# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
  
  def twitter
    @user = User.find_or_create_by(user_params)
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_messege(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end
  
  def google_oauth2
    @user = User.find_or_create_by(user_params)
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_messege(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end
  
  def github
    @user = User.find_or_create_by(user_params)
    
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_messege(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  private
  def user_params
    request.env["omniauth.auth"].slice(:provider, :uid).to_h
  end
  
end
