require 'spec_helper'

describe "banks/index" do
  before(:each) do
    assign(:banks, [
      stub_model(Bank,
        :bankname => "Bankname",
        :branchname => "Branchname",
        :holdername => "Holdername",
        :accountnumber => "Accountnumber",
        :swiftcode => "Swiftcode"
      ),
      stub_model(Bank,
        :bankname => "Bankname",
        :branchname => "Branchname",
        :holdername => "Holdername",
        :accountnumber => "Accountnumber",
        :swiftcode => "Swiftcode"
      )
    ])
  end

  it "renders a list of banks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Bankname".to_s, :count => 2
    assert_select "tr>td", :text => "Branchname".to_s, :count => 2
    assert_select "tr>td", :text => "Holdername".to_s, :count => 2
    assert_select "tr>td", :text => "Accountnumber".to_s, :count => 2
    assert_select "tr>td", :text => "Swiftcode".to_s, :count => 2
  end
end
