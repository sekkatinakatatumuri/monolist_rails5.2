class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      # 商品コード
      t.string :code
      # 商品名
      t.string :name
      # 商品URL
      t.string :url
      # 商品画像URL
      t.string :image_url

      t.timestamps
    end
  end
end
