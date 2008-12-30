class ReplaceShowChildLinksWithShowChildLinksAt < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.remove :show_child_links
      t.string :show_child_links_at, :default => 'top'
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :show_child_links_at
      t.boolean :show_child_links, :default => 'true'
    end
  end
end
