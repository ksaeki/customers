class Attachment < ActiveRecord::Base
  attr_accessor :file
  belongs_to :customer
  
  scope :select_no_rawdata, lambda {
    select(Attachment.columns.map(&:name) - ['rawdata'])
  }
  default_scope {select_no_rawdata}
  
end
