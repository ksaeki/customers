json.array!(@banks) do |bank|
  json.extract! bank, :id, :bankname, :branchname, :bankcode, :branchcode, :swiftcode, :address
  json.url bank_url(bank, format: :json)
end
