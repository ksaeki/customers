class Customer < ActiveRecord::Base
  # :accountid, :fullname, :password, :zipcode, :address, :country, :birthday, :sex, :nationality, :tel, :fax, :mobile, :email, :parentid, :bank_id, :holderid, :remark, :service1, :service2, :cbc

  belongs_to :bank
  has_many :attachments

  validates :accountid, :fullname, :password, :presence => true
  validates :email, :format => /\A(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))?\z/
  validates :accountid, :fullname, :password, :zipcode, :address, :country, 
            :birthday, :sex, :nationality, :tel, :fax, :mobile, :email, :parentid, 
            :bank_id, :holderid, :service1, :service2, :cbc, 
            :format => { :with => /\A[ -~｡-ﾟ]*\z/, :message => ": Please enter only single-byte characters." }

  def self.to_csv
    headers = %w(ID AccountID FullName Password Zipcode Address Country Birthday SEX Nationality TEL FAX Mobile Email ParentID BankID AccountHolderID Service1 Service2 BaseCurrency CreatedAt UpdatedAt)
    csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
      all.each do |row|
        csv << row.attributes.values_at(*self.column_names)
      end
    end
    csv_data.encode(Encoding::SJIS)
  end

  def prev
    Customer.first(:conditions => ['id < ?', self.id], :order => 'id DESC')
  end

  def next
    Customer.first(:conditions => ['id > ?', self.id], :order => 'id ASC')
  end
end
