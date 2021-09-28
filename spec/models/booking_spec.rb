require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'confirm' do
    subject(:confirm) { booking.confirm }
    let(:booking) { create(:booking, user: user) }
    let(:user) { create(:user, :approved) }

    context 'when the user has been approved' do
      it 'updates the booking to confirmed' do
        expect { confirm }.to change { booking.state }.from('provisional').to('confirmed')
         .and change { booking.confirmed_at }.to(a_kind_of(Time))
      end
    end

    context 'when the user has not been approved' do
      let(:user) { create(:user) }

      it 'does not update the booking to confirmed' do
        expect { confirm }.to not_change { booking.reload.state }
         .and not_change { booking.confirmed_at }
      end
    end

    context 'when the booking is in the future' do
      let(:booking) { create(:booking, start_time: DateTime.tomorrow, user: user) }

      it 'updates the booking to confirmed' do
        expect { confirm }.to change { booking.reload.state }.from('provisional').to('confirmed')
         .and change { booking.confirmed_at }.to(a_kind_of(Time))
      end
    end

    context 'when the booking is in the past' do
      let(:booking) { create(:booking, start_time: DateTime.yesterday, user: user) }

      it 'does not update the booking to confirmed' do
        expect { confirm }.to not_change { booking.reload.state }
         .and not_change { booking.confirmed_at }
      end
    end

    context 'when the booking has already been confirmed' do
      before { confirm }

      it 'does not update the booking to confirmed' do
        expect { confirm }.to not_change { booking.reload.state }
         .and not_change { booking.confirmed_at }
      end
    end
  end
end
