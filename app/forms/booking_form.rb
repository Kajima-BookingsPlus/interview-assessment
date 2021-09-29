class BookingForm
  include ActiveModel::Model

  attr_accessor :confirmation_type, :send_confirmation_msg, :booking_id

  validates :confirmation_type, inclusion: { in: %w(sms email) }, allow_nil: true
  validates :send_confirmation_msg, inclusion: { in: %w(true false) }, allow_nil: true
end