class Comment < ApplicationRecord
  belongs_to :shop
  belongs_to :user

  validates :comment, presence: true, length: {maximum:256}
  default_scope -> { order(created_at: :desc) }

end
