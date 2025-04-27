class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # 退会処理後の遷移先を指定（新規会員登録時のパスは、デフォルト設定があるのでregistrationコントローラに記載。）
  def after_sign_out_path_for(resource)
    about_path # Aboutページのパス
  end

  protected
  def configure_permitted_parameters
    # ユーザー登録時
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ユーザー編集時
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
