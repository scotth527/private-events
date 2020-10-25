class Event < ApplicationRecord
    belongs_to :host_id, class_name: "User", foreign_key: :user_id
end
