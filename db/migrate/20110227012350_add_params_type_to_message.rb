class AddParamsTypeToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :params_type, :string
    add_column :messages, :params, :text
  end

  def self.down
    remove_column :messages, :params_type
    remove_column :messages, :params
  end
end
