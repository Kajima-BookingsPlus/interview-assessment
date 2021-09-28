class SendConfirmationMessage
  def initialize(booking, params)
    @booking = booking
    @confirmation_type = params[:confirmation_type]
    @send_confirmation_msg = params[:send_confirmation_msg]
  end

  def call
    return unless @send_confirmation_msg

    sms? ? send_sms_messages : send_emails
  end

  private

  def sms?
    @confirmation_type == 'sms'
  end

  def send_sms_messages
    users_to_notify.compact.each do |user|
      next unless user.mobile
      ::SmsSender.new(user.mobile, 'Booking confirmed').deliver
    end
  end

  def send_emails
    users_to_notify.each do |user|
      ConfirmationMailer.with(user: user).booking_confirmation_email.deliver_later
    end
  end

  def users_to_notify
    [@booking.user, @booking.host]
  end
end