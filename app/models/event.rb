class Event < ApplicationRecord
    belongs_to :creator, class_name: "User", foreign_key: :user_id
    has_many :rsvps
    has_many :attendees, through: :rsvps, :foreign_key => :attendee_id
end
