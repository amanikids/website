class AddSeparateMonthlyDonationAmountsToDonationPages < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.rename :donation_amounts, :one_time_donation_amounts
      t.string :monthly_donation_amounts, :default => ''
      t.string :monthly_donation_level_names, :default => ''
    end
  end

  def self.down
    change_table :contents do |t|
      t.rename :one_time_donation_amounts, :donation_amounts
      t.remove :monthly_donation_amounts
      t.remove :monthly_donation_level_names
    end
  end
end
