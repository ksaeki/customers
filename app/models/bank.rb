require 'csv'
require 'pp'

class Bank < ActiveRecord::Base

  validates :bankname, :presence => true

  scope :search_or, lambda { |fields|
    conditions = nil
    fields = [fields] if fields.class == Symbol
    fields.each do |field, value|
      if conditions.nil?
        conditions = arel_table[field].matches('%' + value + '%')
      else
        conditions = conditions.or(arel_table[field].matches('%' + value + '%'))
      end
    end
    where(conditions)
  }

  scope :search_and, lambda { |fields|
    conditions = nil
    fields = [fields] if fields.class == Symbol
    fields.each do |field, value|
      if conditions.nil?
        conditions = arel_table[field].matches('%' + value + '%')
      else
        conditions = conditions.and(arel_table[field].matches('%' + value + '%'))
      end
    end
    where(conditions)
  }

  def self.to_csv
    headers = %w(ID BankName BranchName HolderName Address SwiftCode CreatedAt UupdatedAt)
    csv_data = CSV.generate(headers: headers, write_headers: true, force_quotes: true) do |csv|
      all.each do |row|
        csv << row.attributes.values_at(*self.column_names)
      end
    end
    csv_data.encode(Encoding::SJIS, :invalid => :replace, :undef => :replace)
  end

end
