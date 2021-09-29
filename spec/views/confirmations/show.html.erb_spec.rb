require 'rails_helper'

RSpec.describe "confirmations/show", type: :view do
  before(:each) do
    @confirmation = assign(:confirmation, Confirmation.create!(
      booking: nil,
      send_confirmation_msg: false,
      type: "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Type/)
  end
end
