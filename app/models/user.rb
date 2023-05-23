# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bookings

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password
end
