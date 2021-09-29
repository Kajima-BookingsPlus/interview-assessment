class ConfirmBooking
  def initialize(booking, booking_params)
    @booking = booking
    @booking_params = booking_params
  end

  def call
    booking_form = BookingForm.new(@booking_params)
    booking_form.valid?
    return booking_form unless booking_form.errors.empty?

    @booking.confirmed_by_id = @booking.user.id

    if @booking.confirm
      SendConfirmationMessage.new(@booking, @booking_params).call
    end

    @booking
  end
end
