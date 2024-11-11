# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string           not null
#  last_name       :string
#  username        :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username) UNIQUE
#

class User < ApplicationRecord
  has_person_name
  has_secure_password

  has_one :profile, dependent: :destroy
  has_many :sessions, dependent: :destroy

  normalizes :username, with: ->(e) { e.strip.downcase }

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]{2,32}\z/ }

  after_create_commit :create_profile
end
