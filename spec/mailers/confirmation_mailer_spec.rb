require 'rails_helper'

RSpec.describe ConfirmationMailer, type: :mailer do
  describe '#booking_confirmation_email' do
    subject(:mailer) do
      described_class.with(user: user)
    end
    let(:mail) { mailer.booking_confirmation_email }
    let(:user) { create(:user) }

    it 'outputs the correct email' do
      expect(mail.body).to eq('Your booking has been confirmed')
      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq('Booking confirmed')
    end
  end
end