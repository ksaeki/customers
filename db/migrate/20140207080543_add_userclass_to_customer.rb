class AddUserclassToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :userclass, :integer
  end
end
