module Api
  module V1
    class BookingsController < ApplicationController
      def confirm
        booking = Booking.find(params[:booking_id])

        if booking.confirm
          render status: :ok, json: booking
        else
          render status: :unprocessable_entity, json: {
              errors: booking.errors.full_messages
          }
        end
      end
    end
  end
end