class User < ApplicationRecord
  has_person_name
  has_secure_password

  has_many :sessions, dependent: :destroy

  normalizes :username, with: ->(e) { e.strip.downcase }

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]{2,32}\z/ }
end
