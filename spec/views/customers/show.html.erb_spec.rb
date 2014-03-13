require 'spec_helper'

describe "customers/show" do
  before(:each) do
    @customer = assign(:customer, stub_model(Customer,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Accountid/)
    rendered.should match(/Fullname/)
    rendered.should match(/Password/)
    rendered.should match(/Zipcode/)
    rendered.should match(/Address/)
    rendered.should match(/Country/)
    rendered.should match(/Sex/)
    rendered.should match(/Nationality/)
    rendered.should match(/Tel/)
    rendered.should match(/Fax/)
    rendered.should match(/Mobile/)
    rendered.should match(/Email/)
    rendered.should match(/Parentid/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Cbc/)
  end
end
