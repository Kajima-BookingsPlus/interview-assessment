require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'confirm' do
    subject(:booking) { create(:booking, user: user) }

    context 'when the user has been approved' do
      let(:user) { create(:user, :approved) }

      it 'updates the booking to confirmed' do
        expect { booking.confirm }.to change { booking.state }.from('provisional').to('confirmed')
         .and change { booking.confirmed_at }.to(a_kind_of(Time))
      end
    end

    context 'when the user has not been approved' do
      let(:user) { create(:user) }

      it 'does not update the booking to confirmed' do
        expect { booking.confirm }.to not_change { booking.state }
         .and not_change { booking.confirmed_at }
      end
    end
  end
end
