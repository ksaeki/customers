json.array!(@branches) do |branch|
  json.extract! branch, :id, :bank_id, :branchname, :branchcode, :address, :swiftcode
  json.url branch_url(branch, format: :json)
end
