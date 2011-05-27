class ChangeTransactionNotificationToText < ActiveRecord::Migration
  def self.up
    change_column(:transactions, :notification, :text)
  end

  def self.down
    change_column(:transactions, :notification, :string)
  end
end
