class AddLeftAndRightColumnToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.text :left_column, :right_column
    end
  end

  def self.down
    change_table :contents do |t|
      t.remove :left_column, :right_column
    end
  end
end
