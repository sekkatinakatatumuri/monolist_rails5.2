class Want < Ownership
  # Want.all を実行すると、 SELECT ownerships.* FROM ownerships WHERE ownerships.type IN ('Want') という SQL が実行され、
  # ownerships のテーブルの type IN ('Want') (type = 'Want' と同じ) なレコードのみを取得できる
  
  # wantのランキング返すクラスメソッド
  def self.ranking
    # .group(:item_id) → レコードを item_id カラムでグループ化
    # .order('count_item_id DESC') → ant のカウントが多い順にソート
    # .count(:item_id) → グループさせた item_id の数をカウント
    # .limit(10) → ランキングに表示する数を10個に絞る
    self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
  end
end
