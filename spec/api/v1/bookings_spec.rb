require 'rails_helper'

RSpec.describe V1::Bookings do
  describe 'PATCH /api/v1/bookings/:id/confirm' do
    let(:user)    { create(:user, :approved) }
    let(:booking) { create(:booking, :provisional, user_id: user.id) }

    before do
      patch "/api/v1/bookings/#{booking.id}/confirm", params: params
    end

    context 'with valid params' do
      let(:params) do
        {

        }
      end

      it 'returns 200 status' do
        expect(response.status).to be(200)
      end

      it 'updates booking state' do
        booking.reload

        expect(booking.state).to eq('confirmed')
      end
    end
  end
end
