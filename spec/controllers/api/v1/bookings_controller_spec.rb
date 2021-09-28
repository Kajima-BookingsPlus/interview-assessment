require 'rails_helper'

RSpec.describe Api::V1::BookingsController, type: :controller do
  let(:user) { create(:user) }

  before do
    http_login(user.email, user.password)
  end

  describe '#confirm' do
    context 'when the correct request body has been provided' do
      context 'when the booking has been found' do
        let(:booking) { create(:booking, :with_host) }

        it 'responds successfully' do
          patch 'confirm', params: { booking_id: booking.id }
          expect(response).to have_http_status(:no_content)
        end
      end

      context 'when the booking has not been found' do
        it 'responds with a not found response' do
          patch 'confirm', params: { booking_id: 10000000 }
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  def http_login(username, password)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end