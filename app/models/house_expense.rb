class HouseExpense < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :house_expense_cycle, :class_name => HouseAccountCycle, :foreign_key => 'house_account_cycle_id'
end
