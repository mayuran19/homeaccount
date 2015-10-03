class AddDefaultAccountCycleDateToHouse < ActiveRecord::Migration
  def change
    add_column :houses, :default_account_cycle_date, :string
  end
end
