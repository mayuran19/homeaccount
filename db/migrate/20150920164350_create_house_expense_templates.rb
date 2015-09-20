class CreateHouseExpenseTemplates < ActiveRecord::Migration
  def change
    create_table :house_expense_templates do |t|
      t.string :expense_name
      t.integer :house_id
      t.integer :recurring_frequency_id
      t.string :recurring_frequency_value
      t.date :effective_from
      t.date :effective_to
      t.boolean :is_mandatory
      t.decimal :default_amount

      t.timestamps null: false
    end
  end
end
