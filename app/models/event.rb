class Event < ApplicationRecord
    belongs_to :host, class_name: "User", foreign_key: :user_id
    has_many :rsvps
    has_many :users, through: :rsvps
end
