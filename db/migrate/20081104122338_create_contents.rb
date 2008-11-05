class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.references :parent
      t.string :type, :title, :slug
      t.text :body
      t.integer :position, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
