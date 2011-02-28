class AddSecretToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :delivery_secret, :string
  end

  def self.down
    remove_column :messages, :delivery_secret
  end
end
