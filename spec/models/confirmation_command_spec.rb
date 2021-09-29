class ConfirmationCommand
  def initialize (booking: booking, send_confirmation_msg: false,confirmation_type: :email)
    @booking = booking
    @send_confirmation_msg = send_confirmation_msg
    @confirmation_type = confirmation_type
  end
  def execute
    if(@booking.user.approved?)
      if(@booking.state == "provisional")

      end
    end

  end
end

RSpec.describe ConfirmationCommand, type: :model do
  context "Send No Confirmation message" do

    it 'should be confirmed given a valid booking' do
      #given
      user = double(:user, approved?: true)
      host = double(:host)
      booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")

      params = {id: 1}
      command = ConfirmationCommand.new(booking: booking)
      #When
      command.execute
      #Then
      expect(booking).to receive(:state) { "confirmed" }
    end
    
  end
  

end
