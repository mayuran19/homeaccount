class HouseExpense < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :house_expense_cycle, :class_name => HouseAccountCycle, :foreign_key => 'house_account_cycle_id'
  has_many :house_expense_per_tenant, :class_name => HouseExpensePerTenant, :foreign_key => 'house_expense_id', :dependent => :destroy
  has_many :tenants, :through => :house_expense_per_tenant

  def self.is_all_fixed_expenses_updated?(house_id, house_account_cycle_id)
  	all_fixed_expenses_updated = true

  	fixed_templates = HouseExpenseTemplate.fixed_expenses_by_house_id(house_id)

  	fixed_template_ids = Array.new
  	fixed_template_map = {}

  	fixed_templates.each do |fixed_template|
  		fixed_template_ids.push(fixed_template.id)
  		fixed_template_map[fixed_template.id] = fixed_template
  	end

  	expenses = HouseExpense.where("house_id = ? and house_account_cycle_id = ? and house_expense_template_id in(?)", house_id, house_account_cycle_id, fixed_template_ids)

  	expenses.each do |expense|
  		fixed_template_map.delete(expense.house_expense_template_id)
  	end

  	if fixed_template_map.size != 0
  		fixed_template_map.each do |k, v|
  			puts "#{v.expense_name} is not updated for house_id: #{house_id} and account_cycle: #{house_account_cycle_id}"
  		end
  		all_fixed_expenses_updated = false
  	end

  	all_fixed_expenses_updated
  end

  def self.total_spending_by_tenants(house_id, account_cycle_id)
  	spending_by_tenants = HouseExpense.find_by_sql(["select t2.id as tenant_id ,COALESCE(t1.amount,0) as amount from(
													select tenant_id, round(sum(amount),2) amount from house_expenses
													where house_id = ? and house_account_cycle_id = ?
													group by tenant_id) t1
													full outer join
													(select id, 0 as amount from tenants) t2 on t1.tenant_id = t2.id",house_id,account_cycle_id])

  	spending_by_tenants
  end
end
