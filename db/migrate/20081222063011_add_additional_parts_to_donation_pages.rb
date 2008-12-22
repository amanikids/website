class AddAdditionalPartsToDonationPages < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.text :footer, :sidebar
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :footer, :sidebar
    end
  end
end
