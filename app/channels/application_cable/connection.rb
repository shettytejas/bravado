module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      set_current_user || reject_unauthorized_connection
    end

    private
      def set_current_user
        if session = Session.find_signed(cookies.signed[:session_id], purpose: :auth)
          self.current_user = session.user
        end
      end
  end
end