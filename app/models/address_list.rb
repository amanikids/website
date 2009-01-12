require 'faster_csv'

class AddressList < ActiveRecord::Base
  EMAIL_ADDRESS_PATTERN = /^\s*[a-z0-9._-]+@([a-z0-9-]+\.)+[a-z]{2,}\s*$/i

  serialize :addresses, Array

  def addresses
    read_attribute(:addresses) || write_attribute(:addresses, [])
  end

  def csv_files=(csv_files)
    csv_files.each do |file|
      FasterCSV.parse(file).each do |row|
        add_unique_addresses(row.grep(EMAIL_ADDRESS_PATTERN))
      end
    end
  end

  def subscriptions=(subscriptions)
    add_unique_addresses(subscriptions.map(&:email))
  end

  private

  def add_unique_addresses(values)
    self.addresses.concat(values.flatten.map { |address| address.strip.downcase })
    self.addresses.sort!
    self.addresses.uniq!
  end
end
