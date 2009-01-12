class CreateAddressLists < ActiveRecord::Migration
  def self.up
    create_table :address_lists do |t|
      t.text :addresses
      t.timestamps
    end
  end

  def self.down
    drop_table :address_lists
  end
end
