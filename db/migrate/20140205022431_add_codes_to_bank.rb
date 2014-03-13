class AddCodesToBank < ActiveRecord::Migration
  def change
    add_column :banks, :bankcode, :integer
    add_column :banks, :branchcode, :integer
  end
end
