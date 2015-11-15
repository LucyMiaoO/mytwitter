    module SessionsHelper

      # Remembers a user in a persistent session.
      def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
      end

      # Returns the user corresponding to the remember token cookie.
      def current_user
        if (user_id = cookies.signed[:user_id])
           user = User.find_by(id: user_id)
           if user 
              @current_user = user
           end
        end
      end

      # Forgets a persistent session.
      def forget(user)
          user.forget
          cookies.delete(:user_id)
          cookies.delete(:remember_token)
      end

      # Logs out the current user.
      def log_out
          forget(current_user)
          @current_user = nil
      end

    end

