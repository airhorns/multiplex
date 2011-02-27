class AddDeliveredToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :delivered, :boolean
  end

  def self.down
    remove_column :messages, :delivered
  end
end
