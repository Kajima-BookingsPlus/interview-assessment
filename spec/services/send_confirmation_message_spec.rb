require 'rails_helper'

RSpec.describe SendConfirmationMessage do
  describe '#call' do
    subject(:send_confirmation) { described_class.new(booking, params).call }

    context 'when the send_confirmation_msg parameter is true' do
      let(:params) do
        {
          send_confirmation_msg: true,
          confirmation_type: confirmation_type
        }
      end

      context 'when the the confirmation type is an sms' do
        let(:confirmation_type) { 'sms' }

        context 'when the user has a number' do
          let(:user) { create(:user, mobile: '0383838383') }
          let(:sms_sender) { instance_double(SmsSender) }
          let(:booking) { create(:booking, :with_host) }

          before do
            allow(SmsSender).to receive(:new).with(booking.user.mobile, 'Booking confirmed').and_return(sms_sender)
            allow(SmsSender).to receive(:new).with(booking.host.mobile, 'Booking confirmed').and_return(sms_sender)
            allow(sms_sender).to receive(:deliver).twice
          end

          it 'sends an sms message to the user' do
            send_confirmation
            expect(sms_sender).to have_received(:deliver).twice
          end
        end

        context 'when the user does not have a number' do
          let(:user) { create(:user, mobile: nil) }
          let(:host) { create(:host, mobile: nil) }
          let(:booking) { create(:booking, user: user, host: host) }

          before { allow(SmsSender).to receive(:new) }

          it 'does not attempt to send an sms message to the user' do
            send_confirmation
            expect(SmsSender).not_to have_received(:new)
          end
        end
      end
    end
  end
end