class Guest < ActiveRecord::Base
  belongs_to :event

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
