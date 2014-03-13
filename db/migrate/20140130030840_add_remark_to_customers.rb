class AddRemarkToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :remark, :text
  end
end
