require 'date'

class ConfirmationCommand
  class Emailer
    def deliver!
    end
  end
  def initialize (booking: booking, send_confirmation_msg: false,confirmation_type: :email,emailer: nil)
    @booking = booking
    @send_confirmation_msg = send_confirmation_msg
    @confirmation_type = confirmation_type
    @emailer = emailer
  end
  def execute
    if(@booking.user.approved?)
      if(@booking.state == "provisional")
        @booking.confirmed!
        @booking.confirmed_at = DateTime.now
        if @send_confirmation_msg == true
          @emailer.deliver! 
        end
      end
    end

  end
end

RSpec.describe ConfirmationCommand, type: :model do
  context "Send No Confirmation message" do
    context "An approved user, a provisional booking in the future " do
      it 'should be confirmed given a valid booking - state confirmed' do
        #given
        user = double(:user, approved?: true)
        host = double(:host)
        booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")
        expect(booking).to receive(:confirmed!) 
        allow(booking).to receive(:confirmed_at=).with(any_args)
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
        expect(booking).to receive(:confirmed_at=).with(any_args)
  
        params = {id: 1}
        command = ConfirmationCommand.new(booking: booking)
        #When
        command.execute
        #Then
  
      end
      it 'should be confirmed given a valid booking - send email' do
        #given
        user = double(:user, approved?: true)
        host = double(:host)
        booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")
  
        allow(booking).to receive(:confirmed!) 
        expect(booking).to receive(:confirmed_at=).with(any_args)
        
        params = {id: 1}
        command = ConfirmationCommand.new(booking: booking)
        #When
        command.execute
        #Then
  
      end
    end 
  end
  context "Send message by email" do
    it 'should be confirmed given a valid booking - send email' do
      #given
      user = double(:user, approved?: true, email: "test@test.com")
      host = double(:host)
      emailer = double(:emailer)
      booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")

      allow(booking).to receive(:confirmed!) 
      allow(booking).to receive(:confirmed_at=).with(any_args)
      expect(emailer).to receive(:deliver!)
      
      params = {id: 1,send_confirmation_msg: true}
      command = ConfirmationCommand.new(booking: booking, emailer: emailer)
      #When
      command.execute
      #Then

    end
  end
  

end
