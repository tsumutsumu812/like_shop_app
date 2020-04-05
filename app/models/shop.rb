class Shop < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20}
  validates :genre, length: { maximum: 10}
  validates :address, length: { maximum: 50}
  belongs_to :user
  has_many :comments
end
