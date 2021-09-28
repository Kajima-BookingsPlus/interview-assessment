class ConfirmBooking
  def initialize(booking, booking_params)
    @booking = booking
    @booking_params = booking_params
  end

  def call
    @booking.confirmed_by_id = @booking.user.id

    if @booking.confirm
      SendConfirmationMessage.new(@booking, @booking_params).call
    end

    @booking
  end
end
