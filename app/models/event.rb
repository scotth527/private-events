class Event < ApplicationRecord
    validates :date, presence: true

    scope :past_events, ->(today) { where("date < ? ", today) }
    scope :upcoming_events, -> (today) { where("date > ?", today) }

    belongs_to :creator, class_name: "User", foreign_key: :user_id
    has_many :rsvps
    has_many :attendees, through: :rsvps, :foreign_key => :attendee_id, dependent: :destroy
end
