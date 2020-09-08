class BookingPolicy < ApplicationPolicy
  def confirm?
    user.approved? &&
      user_owned? &&
      record.start_time.future? &&
      record.state == 'provisional'
  end
end
