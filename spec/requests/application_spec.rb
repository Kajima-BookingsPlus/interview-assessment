require 'rails_helper'

RSpec.describe 'Application', type: :request do
  describe 'GET /' do
    let(:user) { create(:user) }

    it 'returns a 200 status' do
      get '/', headers: basic_auth_headers(user)
      expect(response).to have_http_status(:ok)
    end
  end
end
