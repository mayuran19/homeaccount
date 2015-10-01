class AddDivisionFactorToHouseExpensePerTenant < ActiveRecord::Migration
  def change
    add_column :house_expense_per_tenants, :division_factor, :integer
    add_column :house_expense_per_tenants, :tenant_factor, :integer
  end
end
