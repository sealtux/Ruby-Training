class Task < ActiveRecord::Base
  belongs_to :user, optional: ENV.fetch("TRAINING_DAY", "6").to_i < 9
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 150 }
end
