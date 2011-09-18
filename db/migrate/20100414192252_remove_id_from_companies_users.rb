class RemoveIdFromCompaniesUsers < ActiveRecord::Migration
  def self.up
    remove_column :companies_users, :id
  end

  def self.down
    add_column :companies_users, :id, :integer
  end
end
