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
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
  end
end
