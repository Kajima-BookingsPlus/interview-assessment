class ConfirmationMailer < ApplicationMailer
  def booking_confirmation_email
    mail(to: params[:user].email,
         body: 'Your booking has been confirmed',
         content_type: "text/html",
         subject: 'Booking confirmed')
  end
end