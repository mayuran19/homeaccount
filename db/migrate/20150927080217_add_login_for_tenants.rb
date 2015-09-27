class AddLoginForTenants < ActiveRecord::Migration
  def change
  	add_column :tenants, :email, :string
  	add_column :tenants, :password_hash, :string
  	add_column :tenants, :password_salt, :string
  end
end
