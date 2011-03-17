class AddDeliverySecretToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :delivery_secret, :string
  end

  def self.down
    remove_column :users, :delivery_secret
  end
end
