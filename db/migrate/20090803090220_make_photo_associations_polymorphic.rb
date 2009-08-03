class MakePhotoAssociationsPolymorphic < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.string :content_type
    end
    execute 'UPDATE photos SET content_type="Content"'
  end

  def self.down
    change_table :photos do |t|
      t.remove :content_type
    end
  end
end
