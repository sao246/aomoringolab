# frozen_string_literal: true
# コントローラ追加 2025/04/06 (devise実装)
class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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
  
  # ログイン後はマイページに遷移させる 2025/04/07 追加
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end

