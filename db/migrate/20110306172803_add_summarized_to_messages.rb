class AddSummarizedToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :summarized, :boolean, :default => false
  end

  def self.down
    remove_column :messages, :summarized
  end
end
