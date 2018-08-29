class Item < ApplicationRecord
  validates :code, presence: true, length: { maximum: 255 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  
  # itemモデルから見たとき
  has_many :ownerships
  # throughオプションによりownerships経由でitemsにアクセスできる
  # item.users で item を want/have している users を取得可能
  has_many :users, through: :ownerships
  
  has_many :wants
  has_many :want_users, through: :wants, class_name: 'User', source: :user
end
