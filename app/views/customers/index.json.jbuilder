json.array!(@customers) do |customer|
  json.extract! customer, :id, :accountid, :fullname, :password, :zipcode, :address, :country, :birthday, :sex, :nationality, :tel, :fax, :mobile, :email, :parentid, :bank_id, :service1, :service2, :cbc
  json.url customer_url(customer, format: :json)
end
