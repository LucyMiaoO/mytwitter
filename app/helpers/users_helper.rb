module UsersHelper

      # Returns the Gravatar (http://gravatar.com/) for the given user.
      def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
      end

      def current_user
        if (user_id = cookies.signed[:user_id])
           user = User.find_by(id: user_id)
           if user && 
                user.authenticated?(cookies[:remember_token])
            @current_user = user
          end
        end
      end

      # Returns true if a user is logged in, false otherwise.
      def logged_in?
        !current_user.nil?
      end
      # Returns true if the given user is the current user.
      def current_user?(user)
        user == current_user
      end

    end
