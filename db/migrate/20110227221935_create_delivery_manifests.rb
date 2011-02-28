class CreateDeliveryManifests < ActiveRecord::Migration
  def self.up
    create_table :delivery_manifests do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :delivery_manifests
  end
end
