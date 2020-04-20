class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_secure_password
  validates :name, presence:true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:true, uniqueness: { case_sensitive: false },
             length: { maximum: 100 },
             format: { with: VALID_EMAIL_REGEX }
  validates :introduction, length: { maximum: 256 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  default_scope -> { order(created_at: :desc) }
  has_many :shops, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                    foreign_key: "follower_id",
                    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
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

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Shop.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  def shops
    return Shop.where(user_id: self.id)
  end

  def self.ransacktable_attributes(auth_object=nil)
    %w[name]
  end
  def self.ransacktable_associations(auth_object=nil)
    []
  end
end
