require 'rails_helper'

RSpec.describe Booking, type: :model do
  subject(:booking) { build(:booking) }

  describe '#confirm' do
    subject(:confirm) { booking.confirm }

    let(:booking) { create(:booking, user: user) }
    let(:user) { create(:user) }
    let(:current_time) { Time.parse('Tue, 08 Sep 2020 11:16:15 UTC +00:00') }

    before do
      travel_to current_time
    end

    after do
      travel_back
    end

    it 'sets the resource owner as the booking user' do
      expect { confirm }.to change {
        booking.confirmed_by
      }.to eq user
    end

    it 'sets the current time' do
      expect { confirm }.to change {
        booking.confirmed_at
      }.to eq current_time
    end

    it 'transitions the state to confirmed' do
      expect { confirm }.to change {
        booking.state
      }.to eq 'confirmed'
    end

    context 'given a confirmation user' do
      subject(:confirm) { booking.confirm(confirmation_user: confirmation_user) }

      let(:confirmation_user) { create(:user) }

      it 'sets the confirmation user' do
        expect { confirm }.to change {
          booking.confirmed_by
        }.to eq confirmation_user
      end
    end
  end
end
