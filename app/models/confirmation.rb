# == Schema Information
#
# Table name: confirmations
#
#  id                    :integer          not null, primary key
#  send_confirmation_msg :boolean
#  type                  :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
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
end
