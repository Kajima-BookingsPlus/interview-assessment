require 'rails_helper'

RSpec.describe Api::V1::BookingsController, type: :controller do
  describe '#confirm' do
    let(:user) { create(:user, :approved) }

    context 'when the user is authorized to confirm' do
      before do
        http_login(user.email, user.password)
      end

      context 'when the booking has been found' do
        context 'when the booking can be confirmed' do
          let(:booking) { create(:booking, :with_host, start_time: DateTime.tomorrow, user: user) }
          let(:expected_response) do
            {
                confirmed_at: a_kind_of(String),
                confirmed_by_id: nil,
                created_at: a_kind_of(String),
                state: 'confirmed',
                updated_at: a_kind_of(String),
                user_id: user.id
            }.stringify_keys
          end

          it 'responds successfully' do
            patch 'confirm', params: { booking_id: booking.id }
            expect(response).to have_http_status(:ok)
            expect(JSON.parse(response.body)).to include(expected_response)
          end
        end

        context 'when the booking cannot be confirmed' do
          let(:booking) { create(:booking, :with_host, user: user, state: 'cancelled') }
          let(:expected_response) do
            {
              errors: [ "State cannot transition via \"confirm\""]
            }.stringify_keys
          end

          it 'responds unsuccessfully' do
            patch 'confirm', params: { booking_id: booking.id }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)).to include(expected_response)
          end
        end
      end

      context 'when the booking has not been found' do
        it 'responds with a not found response' do
          patch 'confirm', params: { booking_id: 10000000 }
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when the user is not authorized to confirm' do
      let(:another_user) { create(:user, :approved) }
      let(:booking) { create(:booking, :with_host, start_time: DateTime.tomorrow, user: user) }

      before do
        http_login(another_user.email, another_user.password)
      end

      it 'responds with a not found response' do
        patch 'confirm', params: { booking_id: booking.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  def http_login(username, password)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
  end
end