class OnboardingsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  disallow_if_authenticated only: %i[ new create ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  before_action :ensure_onboarding_is_incomplete

  def new; end

  def create
    user = User.create!(create_params)

    start_new_session_for user
    redirect_to edit_profile_path, notice: "Welcome to Bravado! Complete your profile!"
  end

  private

  def create_params
    params.expect(user: [:name, :username, :password])
  end

  def ensure_onboarding_is_incomplete
    redirect_to root_path if User.any?
  end
end
