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

require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
