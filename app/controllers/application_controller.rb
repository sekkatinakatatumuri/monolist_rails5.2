class ApplicationController < ActionController::Base
  # CSRF対策が有効に
  # もしセキュリティトークンが想定されている値と一致しなければ、例外を投げる
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def require_user_logged_in
    # ログインしていなかったら
    unless logged_in?
      #  指定されたページにリダイレクト
      redirect_to login_url
    end
  end
end
