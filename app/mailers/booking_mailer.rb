class BookingMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmed(*recipients)
    @booking = params['booking']
    mail(to: recipients, subject: "Booking #{@booking.id} confirmed")
  end
end
