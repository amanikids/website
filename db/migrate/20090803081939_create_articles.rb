class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.references :newsletter
      t.string :title
      t.string :subtitle
      t.text :body
      t.integer :position, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
