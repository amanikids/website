class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.date :published_on
      t.string :unsubscribe_url, :default => 'http://www.able-travel.com/amani/leave.htm'
      t.timestamps
    end
  end

  def self.down
    drop_table :newsletters
  end
end
