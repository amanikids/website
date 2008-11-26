class AddCaptionToPhotos < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.text :caption
    end
  end

  def self.down
    change_table :photos do |t|
      t.remove :caption
    end
  end
end
