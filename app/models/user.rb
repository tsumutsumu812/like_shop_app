class User < ApplicationRecord
  has_secure_password
  validates :name, presence:true
  validates :email, {uniqueness: true}
  has_many :shops, dependent: :destroy
  has_many :likes, dependent: :destroy
  def shops
    return Shop.where(user_id: self.id)
  end
end
