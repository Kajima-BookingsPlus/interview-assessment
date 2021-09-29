module Api
  module V1
    class BookingsController < ApplicationController
      before_action :authorized_to_confirm
      skip_before_action :verify_authenticity_token

      def confirm
        confirm_booking = ConfirmBooking.new(booking, booking_params).call

        if confirm_booking.errors.empty?
          render status: :ok, json: confirm_booking
        else
          render status: :unprocessable_entity, json: {
              errors: confirm_booking.errors.full_messages
          }
        end
      end

      private

      def booking_params
        params.permit(:booking_id, :confirmation_type, :send_confirmation_msg)
      end

      def authorized_to_confirm
        unless booking.user.id == current_user.id
          render_404
        end
      end

      def booking
        @booking ||= Booking.find(params[:booking_id])
      end
    end
  end
end