class Shop < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30}
  validates :area, length: { maximum: 10}
  validates :genre, length: { maximum: 10}
  validates :address, length: { maximum: 50}
  validates :likey, length: { maximum: 50}
  validates :description, length: { maximum: 500 }
  validate :picture_size
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  mount_uploader :picture, PictureUploader


  def user
    return User.find_by(id: self.user_id)
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def self.ransacktable_attributes(auth_object=nil)
    %w[name]
  end
  def self.ransacktable_associations(auth_object=nil)
    []
  end

end
