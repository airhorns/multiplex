class AddMailToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :mail, :text
    remove_column :messages, :html_body
    remove_column :messages, :text_body
  end

  def self.down
    remove_column :messages, :mail
    add_column :messages, :html_body, :text
    add_column :messages, :text_body, :text
  end
end
