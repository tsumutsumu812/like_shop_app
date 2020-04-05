class Comment < ApplicationRecord
  belongs_to :shop

  validates :name, presence: true, length: {maximum: 10}
  validates :comment, presence: true, length: {maximum:256}
end
