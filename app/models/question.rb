class Question < ApplicationRecord
  validates :content, length: { maximum: 30 }
  belongs_to :user
  has_many :answers
end
