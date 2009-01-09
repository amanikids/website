class AddDonationMethodToDonationPages < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.string :online_donation_method
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :online_donation_method
    end
  end
end
