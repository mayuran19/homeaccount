class AddDefaultPayeeToHouseExpenseTemplate < ActiveRecord::Migration
  def change
    add_column :house_expense_templates, :default_payee_id, :integer
  end
end
