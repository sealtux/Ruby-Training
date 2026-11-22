class Event < ActiveRecord::Base
  belongs_to :user
  has_many :guests, dependent: :destroy

  accepts_nested_attributes_for :guests, reject_if: :all_blank, allow_destroy: true

  before_validation :set_default_end_time
  before_validation :normalize_title

  validates :title, :location, :starts_at, :ends_at, presence: true
  validate :ends_after_start

  def schedule_label
    return "Happening today" if starts_at.to_date == Date.current
    return "Completed" if ends_at < Time.current

    "Upcoming"
  end

  private

  def set_default_end_time
    self.ends_at = starts_at + 2.hours if starts_at.present? && ends_at.blank?
  end

  def normalize_title
    self.title = title.to_s.squish
  end

  def ends_after_start
    errors.add(:ends_at, "must be after the start time") if starts_at.present? && ends_at.present? && ends_at <= starts_at
  end
end
