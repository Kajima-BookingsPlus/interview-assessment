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

          it 'does not attempt to send an sms message to the user' do
            expect(SmsSender).not_to receive(:new)
            send_confirmation
          end
        end
      end

      context 'when the confirmation type is an email' do
        let(:user) { create(:user) }
        let(:booking) { create(:booking, :with_host) }
        let(:confirmation_type) { 'email' }
        let(:mailer) do
          instance_double(
           ConfirmationMailer,
           booking_confirmation_email: OpenStruct.new(deliver_later: true)
          )
        end

        before do
          allow(ConfirmationMailer).to receive(:with).and_return(mailer)
        end

        it 'sends an email to the host and booking user' do
          send_confirmation
          expect(ConfirmationMailer).to have_received(:with).twice
          expect(mailer).to have_received(:booking_confirmation_email).twice
        end
      end
    end
  end
end