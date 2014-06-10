json.array!(@branches) do |branch|
  json.extract! branch, :id, :bank_id, :branchname, :branchcode, :swiftcode, :address
  json.url branch_url(branch, format: :json)
end
