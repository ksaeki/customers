require 'spec_helper'

describe "branches/index" do
  before(:each) do
    assign(:branches, [
      stub_model(Branch,
        :bank_id => 1,
        :branchname => "Branchname",
        :branchcode => 2,
        :address => "Address",
        :swiftcode => "Swiftcode"
      ),
      stub_model(Branch,
        :bank_id => 1,
        :branchname => "Branchname",
        :branchcode => 2,
        :address => "Address",
        :swiftcode => "Swiftcode"
      )
    ])
  end

  it "renders a list of branches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Branchname".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Swiftcode".to_s, :count => 2
  end
end
