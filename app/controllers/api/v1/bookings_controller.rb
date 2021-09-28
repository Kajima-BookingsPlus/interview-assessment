module Api
  module V1
    class BookingsController < ApplicationController
      def confirm
        booking = Booking.find(params[:booking_id])
        booking.update_attributes(confirmed_at: Time.zone.now, state: 'confirmed')
      end
    end
  end
end