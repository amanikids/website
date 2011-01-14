require 'csv'

class AddressList < ActiveRecord::Base
  EMAIL_ADDRESS_PATTERN = /^\s*[a-z0-9._-]+@([a-z0-9-]+\.)+[a-z]{2,}\s*$/i

  serialize :addresses, Array

  before_save :uniquify_addresses

  def addresses
    read_attribute(:addresses) || write_attribute(:addresses, [])
  end

  def csv_files=(csv_files)
    csv_files.each do |file|
      CSV.parse(file).each do |row|
        add_addresses(row.grep(EMAIL_ADDRESS_PATTERN))
      end
    end
  end

  def subscriptions=(subscriptions)
    add_addresses(subscriptions.map(&:email))
  end

  private

  def add_addresses(values)
    self.addresses.concat(values.flatten.map { |address| address.strip.downcase })
  end

  def uniquify_addresses
    self.addresses.sort!
    self.addresses.uniq!
  end
end
