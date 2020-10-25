class Rsvp < ApplicationRecord
    belongs_to :invitee, class_name: "User", foreign_key: :user_id
    belongs_to :event_id, class_name: "Event", foreign_key: :event_id
end
