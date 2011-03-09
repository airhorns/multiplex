class AddDeliverySecretToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :delivery_secret, :string
    User.find_each do |user|
      user.set_delivery_secret
      user.save!
    end
  end

  def self.down
    remove_column :users, :delivery_secret
  end
end
