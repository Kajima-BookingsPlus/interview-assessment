# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :host, optional: true
  belongs_to :confirmed_by, class_name: 'User', optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true

  def confirm(confirmation_user: user)
    update!(
      confirmed_by: confirmation_user,
      confirmed_at: Time.current,
      state: :confirmed
    )
  end
end
