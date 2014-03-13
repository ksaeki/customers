json.array!(@banks) do |bank|
  json.extract! bank, :id, :bankname, :branchname, :holdername, :accountnumber, :swiftcode
  json.url bank_url(bank, format: :json)
end
