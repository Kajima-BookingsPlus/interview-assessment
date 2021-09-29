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
class Host < ApplicationRecord
  has_many :bookings

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  def full_name
    "#{first_name} #{last_name}"
  end
end
