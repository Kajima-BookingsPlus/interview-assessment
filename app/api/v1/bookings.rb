module V1
  class Bookings < Grape::API
    prefix 'api'
    version 'v1', using: :path
    format :json

    namespace :bookings do
      route_param :id do
        params do
          optional :send_confirmation_msg, type: Boolean
          optional :confirmation_type, type: String
        end

        patch :confirm do
          booking = Booking.find_by(id: params[:id])
          user = User.find_by(id: booking.user_id)

          if booking.state == 'provisional' && user.approved?
            booking.update(state: 'confirmed', confirmed_at: Time.current, confirmed_by_id: user.id)

            status 200
          end
        end
      end
    end
  end
end
