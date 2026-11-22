class User < ActiveRecord::Base
  has_secure_password
  has_many :tasks, dependent: :destroy
  has_many :events, dependent: :destroy
  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 10 }, if: -> { new_record? || password.present? }
end
