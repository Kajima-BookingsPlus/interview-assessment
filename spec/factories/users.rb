# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  approved        :boolean          default(FALSE), not null
#  email           :string
#  first_name      :string
#  last_name       :string
#  mobile          :integer
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.phone_number }
    password { 'password' }
    password_confirmation { 'password' }

    trait :approved do
      approved { true }
    end
  end
end
