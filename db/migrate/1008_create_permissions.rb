class CreatePermissions < ActiveRecord::Migration
  include TranslationGet

  def self.up
    create_table :permissions do |t|
      t.column :role_id,      :integer, :null => false
      t.column :user_id,      :integer, :null => false
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
    end
    #Make sure the role migration file was generated first    
    Role.create(:rolename => 'administrator')
    #Then, add default admin user
    #Be sure change the password later or in this migration file

    user = User.new
    user.login = "admin"
    user.email = "jeff@snowmoonsoftware.com"
    user.password = "admin"
    user.password_confirmation = "admin"
    user.save(false)
    user.send(:activate!)
    role = Role.find_by_rolename('administrator')
    user = User.find_by_login('admin')
    permission = Permission.new
    permission.role = role
    permission.user = user
    permission.save(false)
  end

  def self.down
    drop_table :permissions
    Role.find_by_rolename('administrator').destroy   
    User.find_by_login('admin').destroy   
  end
end
