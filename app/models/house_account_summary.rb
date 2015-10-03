class HouseAccountSummary < ActiveRecord::Base
	belongs_to :tenant, :class_name => Tenant, :foreign_key => 'tenant_id'
	belongs_to :to_tenant, :class_name => Tenant, :foreign_key => 'to_tenant_id'
	belongs_to :account_cycle, :class_name => HouseAccountCycle, :foreign_key => 'house_account_cycle_id'

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

	def self.get_tenants_to_receive_money(house_id, account_cycle_id)
		sql = "select total_per_tenant.house_id as house_id,total_per_tenant.house_account_cycle_id as account_cycle_id,total_per_tenant.tenant_id as tenant_id,@ (total_per_tenant.amount - spending_by_tenant.amount) as amount from (
				select * from house_account_summaries where account_item = 'TOTAL_PER_ACCOUNT_CYCLE_PER_TENANT' and house_id = ? and house_account_cycle_id = ?
				) total_per_tenant
				inner join
				(
				select * from house_account_summaries where account_item = 'TOTAL_SPENDING_PER_ACCOUNT_CYCLE_PER_TENANT' and house_id = ? and house_account_cycle_id = ?
				) spending_by_tenant on total_per_tenant.house_id = spending_by_tenant.house_id
				and total_per_tenant.house_account_cycle_id = spending_by_tenant.house_account_cycle_id
				and total_per_tenant.tenant_id = spending_by_tenant.tenant_id
				where (total_per_tenant.amount - spending_by_tenant.amount) < 0 order by (total_per_tenant.amount - spending_by_tenant.amount) asc"
		receivers = HouseAccountSummary.find_by_sql([sql, house_id, account_cycle_id, house_id, account_cycle_id])
	end

	def self.get_tenants_to_pay_money(house_id, account_cycle_id)
		sql = "select total_per_tenant.house_id as house_id,total_per_tenant.house_account_cycle_id as account_cycle_id,total_per_tenant.tenant_id as tenant_id,total_per_tenant.amount - spending_by_tenant.amount as amount from (
				select * from house_account_summaries where account_item = 'TOTAL_PER_ACCOUNT_CYCLE_PER_TENANT' and house_id = 1 and house_account_cycle_id = 1
				) total_per_tenant
				inner join
				(
				select * from house_account_summaries where account_item = 'TOTAL_SPENDING_PER_ACCOUNT_CYCLE_PER_TENANT' and house_id = 1 and house_account_cycle_id = 1
				) spending_by_tenant on total_per_tenant.house_id = spending_by_tenant.house_id
				and total_per_tenant.house_account_cycle_id = spending_by_tenant.house_account_cycle_id
				and total_per_tenant.tenant_id = spending_by_tenant.tenant_id
				where (total_per_tenant.amount - spending_by_tenant.amount) > 0 order by (total_per_tenant.amount - spending_by_tenant.amount) desc"

		payers = HouseAccountSummary.find_by_sql([sql, house_id, account_cycle_id, house_id, account_cycle_id])
	end

	def self.get_tenants_with_zero_balance(house_id, account_cycle_id)
		sql = "select total_per_tenant.house_id as house_id,total_per_tenant.house_account_cycle_id as account_cycle_id,total_per_tenant.tenant_id as tenant_id,total_per_tenant.amount - spending_by_tenant.amount as amount from (
				select * from house_account_summaries where account_item = 'TOTAL_PER_ACCOUNT_CYCLE_PER_TENANT' and house_id = 1 and house_account_cycle_id = 1
				) total_per_tenant
				inner join
				(
				select * from house_account_summaries where account_item = 'TOTAL_SPENDING_PER_ACCOUNT_CYCLE_PER_TENANT' and house_id = 1 and house_account_cycle_id = 1
				) spending_by_tenant on total_per_tenant.house_id = spending_by_tenant.house_id
				and total_per_tenant.house_account_cycle_id = spending_by_tenant.house_account_cycle_id
				and total_per_tenant.tenant_id = spending_by_tenant.tenant_id
				where (total_per_tenant.amount - spending_by_tenant.amount) = 0"

		tenants_zero_balance = HouseAccountSummary.find_by_sql([sql, house_id, account_cycle_id, house_id, account_cycle_id])
	end

	def self.calculate_tenants_settlement(house_id, account_cycle_id)
		receivers = self.get_tenants_to_receive_money(house_id, account_cycle_id)
		puts receivers
		payers = self.get_tenants_to_pay_money(house_id, account_cycle_id)
		puts payers
		tenants_zero_balance = self.get_tenants_with_zero_balance(house_id, account_cycle_id)
		puts tenants_zero_balance

		while(payers.size != 0 || receivers.size != 0)
			receiver = receivers.pop
			amount_to_receive = receiver[:amount]

			payer = payers.pop
			amout_to_pay = payer[:amount]

			if(amount_to_receive == amout_to_pay)
				puts "Settle the receiver and payer"
				self.settle_payer(house_id, account_cycle_id, amount_to_receive, payer[:tenant_id], receiver[:tenant_id])
				self.settle_receiver(house_id, account_cycle_id, amount_to_receive, receiver[:tenant_id], payer[:tenant_id])
			elsif (amount_to_receive - amout_to_pay > 0)
				puts "Settle the payer"
				amount_to_receive = amount_to_receive - amout_to_pay
				receiver[:amount] = amount_to_receive
				self.settle_payer(house_id, account_cycle_id, amout_to_pay, payer[:tenant_id], receiver[:tenant_id])
				self.settle_receiver(house_id, account_cycle_id, amout_to_pay, receiver[:tenant_id], payer[:tenant_id])
				receivers.push(receiver)
			else
				puts "Settle the receiver"
				amout_to_pay = amout_to_pay - amount_to_receive
				payer[:amount] = amout_to_pay
				self.settle_payer(house_id, account_cycle_id, amount_to_receive, payer[:tenant_id], receiver[:tenant_id])
				self.settle_receiver(house_id, account_cycle_id, amount_to_receive, receiver[:tenant_id], payer[:tenant_id])
				payers.push(payer)
			end
		end
	end

	def self.settle_payer(house_id, account_cycle_id, amount, tenant_id, to_tenant_id)
		payer_settlement = HouseAccountSummary.new
		payer_settlement.house_id = house_id
		payer_settlement.house_account_cycle_id = account_cycle_id
		payer_settlement.account_item = "TO_BE_PAID_TO"
		payer_settlement.account_item_description = "The amount to be paid to"
		payer_settlement.amount = amount
		payer_settlement.tenant_id = tenant_id
		payer_settlement.to_tenant_id = to_tenant_id
		payer_settlement.save
	end

	def self.settle_receiver(house_id, account_cycle_id, amount, tenant_id, to_tenant_id)
		payer_settlement = HouseAccountSummary.new
		payer_settlement.house_id = house_id
		payer_settlement.house_account_cycle_id = account_cycle_id
		payer_settlement.account_item = "TO_BE_RECEIVED_FROM"
		payer_settlement.account_item_description = "The amount to be received from"
		payer_settlement.amount = amount
		payer_settlement.tenant_id = tenant_id
		payer_settlement.to_tenant_id = to_tenant_id
		payer_settlement.save
	end

	def self.get_total_for_cycle(house_id, account_cycle_id)
		total_summary = HouseAccountSummary.where(:house_id => house_id, :house_account_cycle_id => account_cycle_id, :account_item => 'TOTAL_PER_ACCOUNT_CYCLE').first

		total_summary
	end

	def self.get_tenants_spendings(house_id, account_cycle_id)
		spendings = HouseAccountSummary.where(:house_id => house_id, :house_account_cycle_id => account_cycle_id, :account_item => 'TOTAL_SPENDING_PER_ACCOUNT_CYCLE_PER_TENANT')

		spendings
	end

	def self.get_tenants_expenses(house_id, account_cycle_id)
		expenses = HouseAccountSummary.where(:house_id => house_id, :house_account_cycle_id => account_cycle_id, :account_item => 'TOTAL_PER_ACCOUNT_CYCLE_PER_TENANT')

		expenses
	end

	def self.get_receivers(house_id, account_cycle_id)
		receivers = HouseAccountSummary.where(:house_id => house_id, :house_account_cycle_id => account_cycle_id, :account_item => 'TO_BE_RECEIVED_FROM')

		receivers
	end

	def self.get_payers(house_id, account_cycle_id)
		payers = HouseAccountSummary.where(:house_id => house_id, :house_account_cycle_id => account_cycle_id, :account_item => 'TO_BE_PAID_TO')

		payers
	end
end
