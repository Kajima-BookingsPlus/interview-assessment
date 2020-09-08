require 'rails_helper'

RSpec.describe BookingPolicy do
  subject(:policy) { described_class.new(current_user, booking) }

  let(:current_user) { build :user, :approved }
  let(:booking) { build :booking, state: :provisional, user: current_user }

  describe '#confirm?' do
    subject(:confirm?) { policy.confirm? }

    it { is_expected.to be true }

    context 'given an unapproved user' do
      let(:current_user) { build :user, approved: false }

      it { is_expected.to be false }
    end

    context 'given a resource not owned by current user' do
      let(:user) { build :user }
      let(:booking) { build :booking, user: user }

      it { is_expected.to be false }
    end

    context 'given start time has past' do
      let(:user) { build :user }
      let(:booking) { build :booking, start_time: 1.day.before }

      it { is_expected.to be false }
    end

    context 'given a non provisional state' do
      let(:booking) { build :booking, state: :confirmed }

      it { is_expected.to be false }
    end
  end
end
