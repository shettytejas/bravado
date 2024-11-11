class Current < ActiveSupport::CurrentAttributes
  attribute :session

  delegate :user, to: :session, allow_nil: true
  delegate :profile, to: :user, allow_nil: true
end
