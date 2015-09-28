class HouseExpense < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :house_expense_cycle, :class_name => HouseAccountCycle, :foreign_key => 'house_account_cycle_id'
  has_many :house_expense_per_tenant, :class_name => HouseExpensePerTenant, :foreign_key => 'house_expense_id', :dependent => :destroy
  has_many :tenants, :through => :house_expense_per_tenant
end
