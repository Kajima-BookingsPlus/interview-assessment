# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :host, optional: true
  belongs_to :confirmed_by, class_name: 'User', optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true

  state_machine :initial => :provisional do
    after_transition :on => :confirm, :do => :confirm_booking

    event :confirm do
      transition :provisional => :confirmed, :if => [:user_approved?, :booking_in_future?], unless: [:cancelled?, :expired?]
    end

    event :cancel do
      transition [:provisional, :confirmed] => :cancelled
    end

    event :expire do
      transition :provisional => :expired, unless: [:booking_in_future?, :confirmed?]
    end
  end

  private

  def confirm_booking
    update_attributes(confirmed_at: Time.zone.now)
  end

  def user_approved?
    user.approved?
  end

  def booking_in_future?
    start_time.future?
  end
end
