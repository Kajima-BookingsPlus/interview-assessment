require 'rails_helper'

RSpec.describe BookingForm, type: :model do
  it { should validate_inclusion_of(:confirmation_type).in_array(['email', 'sms']) }
  it { should validate_inclusion_of(:send_confirmation_msg).in_array(['true', 'false']) }
end