require 'rails_helper'

RSpec.describe "confirmations/index", type: :view do
  before(:each) do
    assign(:confirmations, [
      Confirmation.create!(
        booking: nil,
        send_confirmation_msg: false,
        type: "Type"
      ),
      Confirmation.create!(
        booking: nil,
        send_confirmation_msg: false,
        type: "Type"
      )
    ])
  end

  it "renders a list of confirmations" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "Type".to_s, count: 2
  end
end
