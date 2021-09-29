class ConfirmationCommand
  def initialize (params: params)
    @params = params
  end
  def execute

  end
end

RSpec.describe ConfirmationCommand, type: :model do
  context "Send No Confirmation message" do

    it 'should be confirmed given a valid booking' do
      #given
      user = double(:user, approved: true)
      host = double(:host)
      booking = double(:booking,user: user, host: host, start_time: DateTime.now + 5.days, state: "provisional")
      
      params = {id: 1}
      command = ConfirmationCommand.new(booking: booking)
      #When
      command.execute
      #Then
      expect(booking).to receive(:confirmed_at)
      expect(booking).to receive(:state)
      expect(booking).to receive(:confirmed)  
    end
    
  end
  

end
