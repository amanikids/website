class AddCustomizableTextToOnlineDonations < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.string :one_time_donation_title, :default => 'Make a One-time Donation'
      t.text   :one_time_donation_text
      t.string :monthly_donation_title, :default => 'Schedule a Monthly Donation'
      t.text   :monthly_donation_text
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :one_time_donation_title
      t.remove :one_time_donation_text
      t.remove :monthly_donation_title
      t.remove :monthly_donation_text
    end
  end
end
