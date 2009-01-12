require 'faster_csv'

class AddressList < ActiveRecord::Base
  EMAIL_ADDRESS_PATTERN = /^\s*[a-z0-9._-]+@([a-z0-9-]+\.)+[a-z]{2,}\s*$/i

  before_create :serialize_addresses

  def addresses
    @addresses ||= FasterCSV.parse(csv || '').map { |row| row.first }
  end

  def csv_files=(csv_files)
    csv_files.each do |file|
      FasterCSV.parse(file).each do |row|
        add_addresses(row.grep(EMAIL_ADDRESS_PATTERN))
      end
    end
  end

  def subscriptions=(subscriptions)
    add_addresses(subscriptions.map(&:email))
  end

  private

  def add_addresses(values)
    addresses.concat(values.flatten.map { |address| address.strip.downcase })
    addresses.sort!
    addresses.uniq!
  end

  def serialize_addresses
    self.csv = FasterCSV.generate do |stream|
      addresses.each do |email|
        stream << [email]
      end
    end
  end
end
