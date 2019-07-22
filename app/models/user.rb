class User < ApplicationRecord

    has_secure_password

    has_many :reviews, dependent: :nullify
    has_many :ideas, dependent: :nullify
    has_many :likes, dependent: :nullify
    has_many :liked_ideas, through: :likes, source: :idea

    VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true
end
