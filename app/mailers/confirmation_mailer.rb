class ConfirmationMailer < ApplicationMailer
  def booking_confirmation_email
    mail(to: user.email,
         body: 'Your booking has been confirmed',
         content_type: "text/html",
         subject: 'Booking confirmed')
  end

  private

  def user
    params[:user]
  end
end