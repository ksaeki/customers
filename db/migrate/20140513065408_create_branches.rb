class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.integer :bank_id
      t.string :branchname
      t.integer :branchcode
      t.string :address
      t.string :swiftcode

      t.timestamps
    end
  end
end
