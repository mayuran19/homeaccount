class CreateHouseExpenses < ActiveRecord::Migration
  def change
    create_table :house_expenses do |t|
      t.integer :tenant_id
      t.integer :house_expense_template_id
      t.string :expense_name
      t.integer :house_id
      t.decimal :amount
      t.date :spent_date

      t.timestamps null: false
    end
  end
end
