class AddSecretToDeliveryManifest < ActiveRecord::Migration
  def self.up
    add_column :delivery_manifests, :delivery_secret, :string
  end

  def self.down
    remove_column :delivery_manifests, :delivery_secret
  end
end
