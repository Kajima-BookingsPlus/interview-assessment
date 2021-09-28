module Api
  module V1
    class BookingsController < ApplicationController
      def confirm
        booking = Booking.find(params[:booking_id])
        booking.confirm
      end
    end
  end
end