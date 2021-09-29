require 'rails_helper'

RSpec.describe "confirmations/edit", type: :view do
  before(:each) do
    @confirmation = assign(:confirmation, Confirmation.create!(
      booking: nil,
      send_confirmation_msg: false,
      type: ""
    ))
  end

  it "renders the edit confirmation form" do
    render

    assert_select "form[action=?][method=?]", confirmation_path(@confirmation), "post" do

      assert_select "input[name=?]", "confirmation[booking_id]"

      assert_select "input[name=?]", "confirmation[send_confirmation_msg]"

      assert_select "input[name=?]", "confirmation[type]"
    end
  end
end
