class AddEnabledToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :enabled, :boolean, :default => false
    add_column :users, :notes, :text
  end

  def self.down
    remove_column :users, :notes
    remove_column :users, :enabled
  end
end
