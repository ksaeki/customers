class Attachment < ActiveRecord::Base
  attr_accessor :file
  belongs_to :customer
end
