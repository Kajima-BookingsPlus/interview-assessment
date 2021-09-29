require 'rails_helper'

RSpec.describe "confirmations/new", type: :view do
  before(:each) do
    assign(:confirmation, Confirmation.new(
      booking: nil,
      send_confirmation_msg: false,
      type: ""
    ))
  end

  it "renders new confirmation form" do
    render

    assert_select "form[action=?][method=?]", confirmations_path, "post" do

      assert_select "input[name=?]", "confirmation[booking_id]"

      assert_select "input[name=?]", "confirmation[send_confirmation_msg]"

      assert_select "input[name=?]", "confirmation[type]"
    end
  end
end
