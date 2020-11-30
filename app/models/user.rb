class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :rsvps, foreign_key: :attendee_id
  has_many :attended_events, through: :rsvps
end
