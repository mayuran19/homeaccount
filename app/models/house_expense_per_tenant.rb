class HouseExpensePerTenant < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :house_expense

  def self.find_total_expense(house_id, account_cycle_id)
  	total = HouseExpensePerTenant.find_by_sql(["select round(sum(amount),2) as total_expense from house_expense_per_tenants where house_expense_id in(select id from house_expenses where house_id = ? and house_account_cycle_id = ?)", house_id, account_cycle_id])
  	#puts total.first[:total_expense]
  	total.first[:total_expense]
  end

  def self.find_total_expense_per_tenant(house_id, account_cycle_id)
  	total_per_tenants = HouseExpensePerTenant.find_by_sql(["select tenant_id,round(sum(amount),2) as amount from house_expense_per_tenants
															where house_expense_id in(select id from house_expenses where house_id = ? and house_account_cycle_id = ?)
															group by tenant_id", house_id, account_cycle_id])

  	total_per_tenants
  end
end
