# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  bio          :text
#  country_code :string(2)
#  height_in_cm :integer
#  weight_in_kg :integer
#  birth_date   :date
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id) UNIQUE
#

class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  validates :bio, length: { maximum: 255 }
  validates :country_code, presence: true, length: { is: 2 }
  validates :height_in_cm, numericality: { only_integer: true, greater_than: 30, less_than: 300 }
  validates :weight_in_kg, numericality: { only_integer: true, greater_than: 20, less_than: 400 }
  validates :birth_date, presence: true

  validate :birth_date_cannot_be_in_the_future

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the future")
    end
  end

  # TODO: Think about turning this into virtual column.
  def age
    (Date.today - birth_date).to_i / 365
  end

  def country_name
    # TODO: Fix
  end

  # TODO: Think about turning this into virtual column.
  def bmi
    return 0 if height_in_cm.zero? || weight_in_kg.zero?

    weight_in_kg.to_f / ((height_in_cm.to_f / 100) ** 2)
  end

  def bmi_category
    case bmi
    when 0..18.4
      "Underweight"
    when 18.5..24.9
      "Normal weight"
    when 25..29.9
      "Overweight"
    when 30..34.9
      "Obese (Class I)"
    when 35..39.9
      "Obese (Class II)"
    else
      "Obese (Class III)"
    end
  end
end
