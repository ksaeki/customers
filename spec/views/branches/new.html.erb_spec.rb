require 'spec_helper'

describe "branches/new" do
  before(:each) do
    assign(:branch, stub_model(Branch,
      :bank_id => 1,
      :branchname => "MyString",
      :branchcode => 1,
      :address => "MyString",
      :swiftcode => "MyString"
    ).as_new_record)
  end

  it "renders new branch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", branches_path, "post" do
      assert_select "input#branch_bank_id[name=?]", "branch[bank_id]"
      assert_select "input#branch_branchname[name=?]", "branch[branchname]"
      assert_select "input#branch_branchcode[name=?]", "branch[branchcode]"
      assert_select "input#branch_address[name=?]", "branch[address]"
      assert_select "input#branch_swiftcode[name=?]", "branch[swiftcode]"
    end
  end
end
