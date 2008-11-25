class Content < ActiveRecord::Base
  has_attached_file :photo, :styles => { :large => '500x500#', :gallery => '368x500#', :small => '120x120#' }, :default_style => :large, :whiny_thumbnails => true
  has_many :photos, :order => :position
end

class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.references :content
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.integer :position
      t.timestamps
    end

    Content.all(:conditions => 'photo_file_name IS NOT NULL').each do |content|
      Photo.create do |photo|
        photo.content = content
        photo.photo   = content.photo
      end

      content.photo = nil
      content.save
    end

    change_table :contents do |t|
      t.remove :photo_file_name
      t.remove :photo_content_type
      t.remove :photo_file_size
      t.remove :photo_updated_at
    end
  end

  def self.down
    change_table :contents do |t|
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
    end

    Content.reset_column_information
    Content.all.each do |content|
      if content.photos.any?
        content.photo = content.photos.first.photo
        content.save
      end
    end

    Photo.destroy_all
    drop_table :photos
  end
end
