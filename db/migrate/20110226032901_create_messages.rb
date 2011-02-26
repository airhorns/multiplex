class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :to_name
      t.string :to_email
      t.integer :user_id
      t.string :from_name
      t.string :from_email
      t.string :subject
      t.string :html_body
      t.string :text_body

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
