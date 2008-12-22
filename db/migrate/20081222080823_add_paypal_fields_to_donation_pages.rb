class AddPaypalFieldsToDonationPages < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.string :currency, :donation_amounts, :paypal_account
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :currency, :donation_amounts, :paypal_account
    end
  end
end
