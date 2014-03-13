require 'spec_helper'

describe "customers/edit" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
      :accountid => "MyString",
      :fullname => "MyString",
      :password => "MyString",
      :zipcode => "MyString",
      :address => "MyString",
      :country => "MyString",
      :sex => "MyString",
      :nationality => "MyString",
      :tel => "MyString",
      :fax => "MyString",
      :mobile => "MyString",
      :email => "MyString",
      :parentid => "MyString",
      :bank_id => 1,
      :service1 => 1,
      :service2 => 1,
      :cbc => "MyString"
    ))
  end

  it "renders the edit customer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_path(@customer), "post" do
      assert_select "input#customer_accountid[name=?]", "customer[accountid]"
      assert_select "input#customer_fullname[name=?]", "customer[fullname]"
      assert_select "input#customer_password[name=?]", "customer[password]"
      assert_select "input#customer_zipcode[name=?]", "customer[zipcode]"
      assert_select "input#customer_address[name=?]", "customer[address]"
      assert_select "input#customer_country[name=?]", "customer[country]"
      assert_select "input#customer_sex[name=?]", "customer[sex]"
      assert_select "input#customer_nationality[name=?]", "customer[nationality]"
      assert_select "input#customer_tel[name=?]", "customer[tel]"
      assert_select "input#customer_fax[name=?]", "customer[fax]"
      assert_select "input#customer_mobile[name=?]", "customer[mobile]"
      assert_select "input#customer_email[name=?]", "customer[email]"
      assert_select "input#customer_parentid[name=?]", "customer[parentid]"
      assert_select "input#customer_bank_id[name=?]", "customer[bank_id]"
      assert_select "input#customer_service1[name=?]", "customer[service1]"
      assert_select "input#customer_service2[name=?]", "customer[service2]"
      assert_select "input#customer_cbc[name=?]", "customer[cbc]"
    end
  end
end
