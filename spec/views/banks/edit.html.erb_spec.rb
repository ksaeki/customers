require 'spec_helper'

describe "banks/edit" do
  before(:each) do
    @bank = assign(:bank, stub_model(Bank,
      :bankname => "MyString",
      :branchname => "MyString",
      :holdername => "MyString",
      :accountnumber => "MyString",
      :swiftcode => "MyString"
    ))
  end

  it "renders the edit bank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bank_path(@bank), "post" do
      assert_select "input#bank_bankname[name=?]", "bank[bankname]"
      assert_select "input#bank_branchname[name=?]", "bank[branchname]"
      assert_select "input#bank_holdername[name=?]", "bank[holdername]"
      assert_select "input#bank_accountnumber[name=?]", "bank[accountnumber]"
      assert_select "input#bank_swiftcode[name=?]", "bank[swiftcode]"
    end
  end
end
