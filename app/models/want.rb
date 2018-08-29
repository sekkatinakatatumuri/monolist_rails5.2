class Want < Ownership
  # Want.all を実行すると、 SELECT ownerships.* FROM ownerships WHERE ownerships.type IN ('Want') という SQL が実行され、
  # ownerships のテーブルの type IN ('Want') (type = 'Want' と同じ) なレコードのみを取得
end
