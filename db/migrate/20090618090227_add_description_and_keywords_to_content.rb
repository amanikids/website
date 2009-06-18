class AddDescriptionAndKeywordsToContent < ActiveRecord::Migration
  def self.up
    change_table(:contents) do |t|
      t.text :raw_description, :default => ''
      t.text :raw_keywords, :default => ''
    end
  end

  def self.down
    change_table(:contents) do |t|
      t.remove :raw_description
      t.remove :raw_keywords
    end
  end
end
