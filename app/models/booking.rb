# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id              :integer          not null, primary key
#  confirmed_at    :datetime
#  end_time        :datetime
#  start_time      :datetime
#  state           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  confirmed_by_id :integer
#  host_id         :integer
#  user_id         :integer
#
# Indexes
#
#  index_bookings_on_host_id  (host_id)
#  index_bookings_on_user_id  (user_id)
#
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :host, optional: true
  belongs_to :confirmed_by, class_name: 'User', optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true
  def to_s
    return "booking: for #{user.full_name}" if host.nil?
    "booking: #{user.full_name} -> #{host.full_name} - #{state}"
  end
end
