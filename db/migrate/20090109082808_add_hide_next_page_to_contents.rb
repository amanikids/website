class AddHideNextPageToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.boolean :hide_next_page, :default => false
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :hide_next_page
    end
  end
end
