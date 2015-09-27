class AddHouseAccountCycleToHouseExpense < ActiveRecord::Migration
  def change
    add_column :house_expenses, :house_account_cycle_id, :integer
  end
end
