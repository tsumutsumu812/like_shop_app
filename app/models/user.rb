class User < ApplicationRecord
  has_secure_password
  validates :name, presence:true
  validates :email, {uniqueness: true}
  has_many :shops, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                    foreign_key: "follower_id",
                    dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                    foreign_key: "followed_id",
                    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def shops
    return Shop.where(user_id: self.id)
  end
end
