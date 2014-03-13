require 'spec_helper'

describe "banks/show" do
  before(:each) do
    @bank = assign(:bank, stub_model(Bank,
      :bankname => "Bankname",
      :branchname => "Branchname",
      :holdername => "Holdername",
      :accountnumber => "Accountnumber",
      :swiftcode => "Swiftcode"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Bankname/)
    rendered.should match(/Branchname/)
    rendered.should match(/Holdername/)
    rendered.should match(/Accountnumber/)
    rendered.should match(/Swiftcode/)
  end
end
