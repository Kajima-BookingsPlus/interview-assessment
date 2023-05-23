module Helpers
  module Authentication
    def basic_auth_credentials(user)
      ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
    end

    def basic_auth_headers(user)
      { Authorization: basic_auth_credentials(user) }
    end
  end
end
