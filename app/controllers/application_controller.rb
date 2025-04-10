class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # リダイレクト時にフラッシュをクリア
  after_action :clear_flash, only: [:new, :create, :edit, :update, :destroy]
 

  protected
  def configure_permitted_parameters
    # ユーザー登録時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ユーザー編集時
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  private
  def clear_flash
    flash.clear if flash[:alert].present? || flash[:notice].present?
  end
end
