class Customer < ActiveRecord::Base
  # :accountid, :fullname, :password, :zipcode, :address, :country, :birthday, :sex, :nationality, :tel, :fax, :mobile, :email, :parentid, :bank_id, :holderid, :remark, :service1, :service2, :cbc

  belongs_to :bank
  has_many :attachments, :dependent => :destroy

  validates :accountid, :fullname, :password, :presence => true
  validates :email, :format => /\A(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))?\z/
  validates :accountid, :fullname, :password, :zipcode, :address, :country, 
            :birthday, :sex, :nationality, :tel, :fax, :mobile, :email, :parentid, 
            :bank_id, :holderid, :service1, :service2, :cbc, 
            :format => { :with => /\A[ -~｡-ﾟ]*\z/, :message => ": Please enter only single-byte characters." }

  scope :select_for_report, lambda {
    scope = current_scope || relation    # (1) 今の scope を取る (無ければ relation)
    scope = scope.select('*') if scope.select_values.blank?    # (2) select が指定されていなかったら select('*') する.
    scope.select('family_name || given_name AS full_name')    # それに対して本来やりたかった select を行う.
  }

  def self.to_csv
    headers = %w(ID AccountID UserClass FullName Password Zipcode Address Country Birthday SEX Nationality TEL FAX Mobile Email ParentID BankID Service1 Service2 BaseCurrency CreatedAt UpdatedAt AccountHolderID Remark)
    csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
      all.each do |row|
        csv << row.attributes.values_at(*self.column_names)
      end
    end
    begin
      csv_data.encode(Encoding::SJIS, :invalid => :replace, :undef => :replace)
    rescue
      
    end
  end

  def self.to_excel
    title = title.presence || 'customers'
    filename = filename.presence || title
    filename = filename + '_' + Time.now.strftime( "%Y%m%d%H%M%S" ) if filename !~ /_/
    filename += '.xls'
    
    Spreadsheet.client_encoding = "UTF-8"

    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1.name = title
    sheet1[0,0] = title

    colmuns.keys.each_with_index { |(key, val), idx|
      sheet1[2,idx] = val
    }

    self.each_with_index do |cust, row|
      colmuns.each_with_index { |val, col|
        sheet1[row + 3,col] = cust.try(val)
      }
    end
    book.write filename
  end

  def prev
    Customer.first(:conditions => ['id < ?', self.id], :order => 'id DESC')
  end

  def next
    Customer.first(:conditions => ['id > ?', self.id], :order => 'id ASC')
  end
end
