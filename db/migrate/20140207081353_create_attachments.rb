class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :customer_id
      t.string  :filename
      t.integer :filesize
      t.string  :contenttype
      t.string  :extension
      t.binary  :rawdata, :limit => 10.megabyte

      t.timestamps
    end
  end
end
