class CreateManifestEntries < ActiveRecord::Migration
  def self.up
    create_table :manifest_entries do |t|
      t.integer :delivery_manifest_id
      t.integer :message_id
      t.boolean :marked_for_delivery

      t.timestamps
    end
  end

  def self.down
    drop_table :manifest_entries
  end
end
