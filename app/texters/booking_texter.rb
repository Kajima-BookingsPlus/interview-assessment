class BookingTexter
  def confirmed(*recipients)
    @booking = params['booking']

    text to: recipients, content: "Booking #{@booking.id} confirmed"
  end
end
