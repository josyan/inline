class CreateModuleTypesUsers < ActiveRecord::Migration
  def self.up
    create_table :module_types_users, :id => false do |t|
      t.integer :module_type_id
      t.integer :user_id
    end

    # give all users the right to the window module
  end

  def self.down
    drop_table :module_types_users
  end
end
