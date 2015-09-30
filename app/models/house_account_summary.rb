class HouseAccountSummary < ActiveRecord::Base
	def self.calculate_total(house_id, account_cycle_id)
		total_amount = HouseExpensePerTenant.find_total_expense(house_id, account_cycle_id)
		puts "Total expense for house_id: #{house_id} and account_cycle: #{account_cycle_id} is #{total_amount}"
		total_summary = HouseAccountSummary.new
		total_summary.house_id = house_id
		total_summary.house_account_cycle_id = account_cycle_id
		total_summary.account_item = "TOTAL_PER_ACCOUNT_CYCLE"
		total_summary.account_item_description = "Total amount for period"
		total_summary.amount = total_amount
		total_summary.save
	end

	def self.calculate_total_per_tenant(house_id, account_cycle_id)
		total_per_tenants = HouseExpensePerTenant.find_total_expense_per_tenant(house_id, account_cycle_id)
		total_per_tenants.each do |tenant_total|
			tenant_id = tenant_total[:tenant_id]
			total = tenant_total[:amount]

			total_summary = HouseAccountSummary.new
			total_summary.house_id = house_id
			total_summary.house_account_cycle_id = account_cycle_id
			total_summary.account_item = "TOTAL_PER_ACCOUNT_CYCLE_PER_TENANT"
			total_summary.account_item_description = "Total amount for tenant"
			total_summary.amount = total
			total_summary.tenant_id = tenant_id
			total_summary.save
		end
	end

	def self.calculate_total_spending_by_tenant(house_id, account_cycle_id)
		total_spendings = HouseExpense.total_spending_by_tenants(house_id, account_cycle_id)
		total_spendings.each do |total_spendings|
			tenant_id = total_spendings[:tenant_id]
			total = total_spendings[:amount]

			total_summary = HouseAccountSummary.new
			total_summary.house_id = house_id
			total_summary.house_account_cycle_id = account_cycle_id
			total_summary.account_item = "TOTAL_SPENDING_PER_ACCOUNT_CYCLE_PER_TENANT"
			total_summary.account_item_description = "Total amount spent by tenant"
			total_summary.amount = total
			total_summary.tenant_id = tenant_id
			total_summary.save
		end
	end
end
