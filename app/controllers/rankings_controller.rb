class RankingsController < ApplicationController
  def want
    # Wantモデルのrankingクラスメソッドの戻り値を格納
    @ranking_counts = Want.ranking
    
    # @ranking_counts.keys でハッシュから item_id だけ取り出した配列を取得
    # それらの items を @items = Item.find(@ranking_counts.keys) で items を取得
    @items = Item.find(@ranking_counts.keys)
  end
  
  def have
    @ranking_counts = Have.ranking
    @items = Item.find(@ranking_counts.keys)
  end
end