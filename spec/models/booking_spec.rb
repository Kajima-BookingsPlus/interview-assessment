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
require 'rails_helper'

RSpec.describe Booking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
