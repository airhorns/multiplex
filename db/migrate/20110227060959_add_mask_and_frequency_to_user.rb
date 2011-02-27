class AddMaskAndFrequencyToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :mask_email, :string
    add_column :users, :summary_frequency, :string
  end

  def self.down
    remove_column :users, :summary_frequency
    remove_column :users, :mask_email
  end
end
