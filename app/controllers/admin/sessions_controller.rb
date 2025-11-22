class Admin::SessionsController < Devise::SessionsController
  # ログイン後のリダイレクト先を管理者ホームに設定
  def after_sign_in_path_for(resource)
    admin_root_path
  end
  
  # ログアウト後のリダイレクト先を管理者ログインに設定
  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end
end
