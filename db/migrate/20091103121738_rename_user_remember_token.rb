class RenameUserRememberToken < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.rename :remember_token, :persistence_token
    end
  end

  def self.down
    change_table :users do |t|
      t.rename :persistence_token, :remember_token
    end
  end
end
