# == Schema Information
#
# Table name: confirmations
#
#  id                    :integer          not null, primary key
#  send_confirmation_msg :boolean
#  type                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not nul
#  booking_id            :integer          not null
#
# Indexes
#
#  index_confirmations_on_booking_id  (booking_id)
#
# Foreign Keys
#
#  booking_id  (booking_id => bookings.id)
#
class Confirmation < ApplicationRecord
  belongs_to :booking
  self.inheritance_column = :_type_disabled
  def confirm(email: EmailSender,current_user:,sms: SmsSender,msg: "notification of booking")
    result = {result: :unconfirmed, message: "Booking unconfirmed, Unapproved user"}
    return unless current_user.approved?

    booking.update state: :confirmed
    booking.update confirmed_at: DateTime.now
    booking.update confirmed_by_id: current_user.id

    if send_confirmation_msg
      if type == "sms"
        sms.new(booking.user.mobile,msg).deliver
        sms.new(booking.host.mobile,msg).deliver if booking.host
        result = { result: :confirmed, message: "Booking confirmed, notified by sms"}
      else
        email.new(booking.user.email,msg).deliver
        email.new(booking.host.email,msg).deliver if booking.host
        result = { result: :confirmed, message: "Booking confirmed, notified by email"}
      end
    end
    result
  end
end
