class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.string :code
      t.integer :user_id
      t.boolean :used
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
