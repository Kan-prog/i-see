class Question < ApplicationRecord
  validates :content, length: { maximum: 500 }
  belongs_to :user
  has_many :answers
end
