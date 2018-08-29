class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  # Gemfile で bcrypt がコメントアウト解除必要
  has_secure_password
  
  # userモデルから見たとき
  has_many :ownerships
  # throughオプションによりownerships経由でitemsにアクセスできる
  # user.items で user が want/have している items を取得可能
  has_many :items, through: :ownerships
end