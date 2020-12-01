class Event < ApplicationRecord
    belongs_to :creator, class_name: "User", foreign_key: :user_id
    has_many :rsvps
    has_many :attendees, through: :rsvps, :foreign_key => :user_id, class_name: :User

end
