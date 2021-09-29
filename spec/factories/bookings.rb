# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id              :integer          not null, primary key
#  confirmed_at    :datetime
#  end_time        :datetime
#  start_time      :datetime
#  state           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  confirmed_by_id :integer
#  host_id         :integer
#  user_id         :integer
#
# Indexes
#
#  index_bookings_on_host_id  (host_id)
#  index_bookings_on_user_id  (user_id)
#
FactoryBot.define do
  factory :booking do
    association :user
    start_time { 1.day.from_now.change(hour: 12) }
    end_time { 1.day.from_now.change(hour: 14) }

    trait :with_host do
      association :host
    end

    trait :provisional do
      state { 'provisional' }
    end

    trait :confirmed do
      state { 'confirmed' }
      confirmed_at { Time.current }
      association :confirmed_by, factory: :user
    end

    trait :cancelled do
      state { 'cancelled' }
    end
  end
end
