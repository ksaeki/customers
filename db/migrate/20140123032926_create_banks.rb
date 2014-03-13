class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :bankname
      t.string :branchname
      t.string :address
      t.string :accountnumber
      t.string :swiftcode
      t.string :holdername

      t.timestamps
    end
  end
end
