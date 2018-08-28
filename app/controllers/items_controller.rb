class ItemsController < ApplicationController
  # ログインチェック
  before_action :require_user_logged_in
  
  def new
    # 最初に検索ページが開かれたときは、検索ワードが入っていないため、
    # nilになりエラーとなるのを防ぐため、空の配列として初期化。
    @items = []

    # フォームから送信された検索キーワードを取得
    @keyword = params[:keyword]
    
    # キーワードが与えられた場合
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1, # 画像アリ
        hits: 20, # 20件
      })

      # resultsから結果を一つずつ取り出しItemモデルインスタンスを作成
      results.each do |result|
        # 検索条件と初期化したいオブジェクトのAttributeと
        # 違う場合はfirst_or_initialize
        # 同じ場合はfind_or_initialize_by
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
    end
  end
  
  private

  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    # 画像 URL 末尾に含まれる ?_ex=128x128 を削除
    # gsub は文字列置換用のメソッドで、第一引数を見つけ出して、第二引数に置換するメソッド
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    # キーにシンボルを使ったハッシュをリターンする？
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
