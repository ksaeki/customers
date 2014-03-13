class AddHolderidToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :holderid, :string
  end
end
