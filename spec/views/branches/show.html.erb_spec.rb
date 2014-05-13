require 'spec_helper'

describe "branches/show" do
  before(:each) do
    @branch = assign(:branch, stub_model(Branch,
      :bank_id => 1,
      :branchname => "Branchname",
      :branchcode => 2,
      :address => "Address",
      :swiftcode => "Swiftcode"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Branchname/)
    rendered.should match(/2/)
    rendered.should match(/Address/)
    rendered.should match(/Swiftcode/)
  end
end
