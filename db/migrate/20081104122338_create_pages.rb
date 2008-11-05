class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.references :section, :parent
      t.string :title, :slug
      t.text :body
      t.integer :position, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
