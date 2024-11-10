class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  disallow_if_authenticated only: %i[ new create ]

  rate_limit to: 10, within: 1.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  before_action :ensure_onbarding_is_completed

  def new
  end

  def create
    if user = User.authenticate_by(create_params)
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another username or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end

  private

  def create_params
    params.expect(user: [:username, :password])
  end

  def ensure_onbarding_is_completed
    redirect_to new_onboarding_path if User.none?
  end
end
