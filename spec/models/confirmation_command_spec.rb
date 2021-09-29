class ConfirmationCommand
  def initialize (booking: booking, send_confirmation_msg: false,confirmation_type: :email)
    @booking = booking
    @send_confirmation_msg = send_confirmation_msg
    @confirmation_type = confirmation_type
  end
  def execute
    if(@booking.user.approved?)
      if(@booking.state == "provisional")
        @booking.confirmed!
        
      end
    end

  end
end

RSpec.describe ConfirmationCommand, type: :model do
  context "Send No Confirmation message" do
    context "An approved user, a provisional booking in teh future " do
      
    end
    
    it 'should be confirmed given a valid booking - state confirmed' do
      #given
      user = double(:user, approved?: true)
      host = double(:host)
      booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")

      expect(booking).to receive(:confirmed!) 
      params = {id: 1}
      command = ConfirmationCommand.new(booking: booking)
      #When
      command.execute
      #Then

    end

    it 'should be confirmed given a valid booking - confirmed at set' do
      #given
      user = double(:user, approved?: true)
      host = double(:host)
      booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")

      allow(booking).to receive(:confirmed!) 
      expect(booking).to receive(:confirmed_at) 
      
      params = {id: 1}
      command = ConfirmationCommand.new(booking: booking)
      #When
      command.execute
      #Then

    end
    
  end
  

end
