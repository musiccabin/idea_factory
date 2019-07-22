class Review < ApplicationRecord
  belongs_to :idea
  belongs_to :user

  validates :description, presence: true
end
