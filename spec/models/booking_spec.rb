require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'confirm' do
    subject(:booking) { create(:booking) }

    it 'updates the booking to confirmed' do
      expect { booking.confirm}.to change { booking.state }.from('provisional').to('confirmed')
       .and change { booking.confirmed_at }.to(a_kind_of(Time))
    end
  end
end
