class Branch < ActiveRecord::Base
  belongs_to :bank

  validates :brancename, :presence => true
  validates :branchname, :swiftcode, :address, 
            :format => { :with => /\A[ -~｡-ﾟ]*\z/, :message => ": Please enter only single-byte characters." }
end
