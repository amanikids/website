class AddShowChildLinksToPage < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.boolean :show_child_links, :default => true
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :show_child_links
    end
  end
end
