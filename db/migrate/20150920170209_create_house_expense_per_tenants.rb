class CreateHouseExpensePerTenants < ActiveRecord::Migration
  def change
    create_table :house_expense_per_tenants do |t|
      t.integer :house_expense_id
      t.integer :tenant_id
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
