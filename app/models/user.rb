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
  
  # Want
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item
  
  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end

  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end

  def want?(item)
    self.want_items.include?(item)
  end
  
  # Have
  has_many :haves, class_name: 'Have'
  has_many :have_items, through: :haves, class_name: 'Item', source: :item

  def have(item)
    self.haves.find_or_create_by(item_id: item.id)
  end
  
  def unhave(item)
    have = self.haves.find_by(item_id: item.id)
    have.destroy if have
  end
  
  def have?(item)
    self.have_items.include?(item)
  end
end