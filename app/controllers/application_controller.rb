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
  
  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
