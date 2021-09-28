class SendConfirmationMessage
  def initialize(booking, params)
    @booking = booking
    @confirmation_type = params[:confirmation_type]
    @send_confirmation_msg = params[:send_confirmation_msg]
  end

  def call
    return unless @send_confirmation_msg

    if sms?
      send_messages
    else

    end
  end

  private

  def sms?
    @confirmation_type == 'sms'
  end

  def send_messages
    [@booking.user.mobile, @booking.host.mobile].compact.each do |number|
      ::SmsSender.new(number, 'Booking confirmed').deliver
    end
  end
end