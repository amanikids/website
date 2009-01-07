class AddShowChildLinksAsToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.string :show_child_links_as, :default => 'links'
      t.string :show_child_links_prompt
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :show_child_links_as
      t.remove :show_child_links_prompt
    end
  end
end
