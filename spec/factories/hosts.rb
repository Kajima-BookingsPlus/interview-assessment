# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  mobile     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :host do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    mobile { Faker::PhoneNumber.phone_number }
  end
end
