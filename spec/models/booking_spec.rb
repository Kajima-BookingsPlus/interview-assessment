require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:booking) { create(:booking, user: user) }
  let(:user) { create(:user, :approved) }

  describe '#confirm' do
    subject(:confirm) { booking.confirm }

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

    context 'when the booking has been cancelled' do
      before { booking.cancel }

      it 'does not update the booking to confirmed' do
        expect { confirm }.to not_change { booking.reload.state }
         .and not_change { booking.confirmed_at }
      end
    end

    context 'when the booking has expired' do
      let(:booking) { create(:booking, start_time: DateTime.yesterday) }

      before { booking.expire }


      it 'does not update the booking to confirmed' do
        expect { confirm }.to not_change { booking.reload.state }
         .and not_change { booking.confirmed_at }
      end
    end
  end

  describe '#cancel' do
    subject(:cancel) { booking.cancel }

    it 'cancels the booking' do
      expect { cancel }.to change { booking.reload.state }.to('cancelled')
    end
  end

  describe '#expire' do
    subject(:expire) { booking.expire }

    context 'when the booking is in the past and has never been confirmed' do
      let(:booking) { create(:booking, start_time: DateTime.yesterday) }

      it 'expires the booking' do
        expect { expire }.to change { booking.reload.state }.to('expired')
      end
    end

    context 'when the booking is in the future' do
      let(:booking) { create(:booking, start_time: DateTime.tomorrow) }

      it 'does not expire the booking' do
        expect { expire }.not_to change { booking.reload.state }
      end
    end

    context 'when the booking is has been confirmed' do
      let(:booking) { create(:booking) }

      before { booking.confirm }

      it 'does not expire the booking' do
        expect { expire }.not_to change { booking.reload.state }
      end
    end
  end
end
