class Comment < ActiveRecord::Base
  belongs_to :task
  validates :body, presence: true, length: { maximum: 2000 }
end
