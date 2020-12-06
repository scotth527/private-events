class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :past_events, ->(today) { where("date < ? ", today) }
  scope :upcoming_events, -> (today) { where("date > ?", today) }

  has_many :events, dependent: :destroy
  has_many :rsvps
  has_many :attended_events, through: :rsvps, class_name: 'Event', dependent: :destroy
end
