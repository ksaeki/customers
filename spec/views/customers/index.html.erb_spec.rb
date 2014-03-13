require 'spec_helper'

describe "customers/index" do
  before(:each) do
    assign(:customers, [
      stub_model(Customer,
        :accountid => "Accountid",
        :fullname => "Fullname",
        :password => "Password",
        :zipcode => "Zipcode",
        :address => "Address",
        :country => "Country",
        :sex => "Sex",
        :nationality => "Nationality",
        :tel => "Tel",
        :fax => "Fax",
        :mobile => "Mobile",
        :email => "Email",
        :parentid => "Parentid",
        :bank_id => 1,
        :service1 => 2,
        :service2 => 3,
        :cbc => "Cbc"
      ),
      stub_model(Customer,
        :accountid => "Accountid",
        :fullname => "Fullname",
        :password => "Password",
        :zipcode => "Zipcode",
        :address => "Address",
        :country => "Country",
        :sex => "Sex",
        :nationality => "Nationality",
        :tel => "Tel",
        :fax => "Fax",
        :mobile => "Mobile",
        :email => "Email",
        :parentid => "Parentid",
        :bank_id => 1,
        :service1 => 2,
        :service2 => 3,
        :cbc => "Cbc"
      )
    ])
  end

  it "renders a list of customers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Accountid".to_s, :count => 2
    assert_select "tr>td", :text => "Fullname".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => "Zipcode".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "Nationality".to_s, :count => 2
    assert_select "tr>td", :text => "Tel".to_s, :count => 2
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Parentid".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Cbc".to_s, :count => 2
  end
end
