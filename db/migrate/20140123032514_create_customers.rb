class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :accountid
      t.string :fullname
      t.string :password
      t.string :zipcode
      t.string :address
      t.string :country
      t.date :birthday
      t.string :sex
      t.string :nationality
      t.string :tel
      t.string :fax
      t.string :mobile
      t.string :email
      t.string :parentid
      t.integer :bank_id
      t.integer :service1
      t.integer :service2
      t.string :cbc

      t.timestamps
    end
  end
end
