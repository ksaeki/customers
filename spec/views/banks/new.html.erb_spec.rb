require 'spec_helper'

describe "banks/new" do
  before(:each) do
    assign(:bank, stub_model(Bank,
      :bankname => "MyString",
      :branchname => "MyString",
      :holdername => "MyString",
      :accountnumber => "MyString",
      :swiftcode => "MyString"
    ).as_new_record)
  end

  it "renders new bank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", banks_path, "post" do
      assert_select "input#bank_bankname[name=?]", "bank[bankname]"
      assert_select "input#bank_branchname[name=?]", "bank[branchname]"
      assert_select "input#bank_holdername[name=?]", "bank[holdername]"
      assert_select "input#bank_accountnumber[name=?]", "bank[accountnumber]"
      assert_select "input#bank_swiftcode[name=?]", "bank[swiftcode]"
    end
  end
end
