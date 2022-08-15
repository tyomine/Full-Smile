# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  #before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]
  
  def after_sign_in_path_for(resource)
   user_path(@user.id)
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  protected
  
    # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      elsif @user.valid_password?(params[:user][:password]) && @user.user_status
        #@userのパスワードが有効かつ退会済み(user_status == true)ならば
        flash[:notice] = 'お客様のアカウントは現在ご使用できません。'
        redirect_to new_user_registration_path #新規登録画面へ遷移させる
      end
  end
  
  
end
