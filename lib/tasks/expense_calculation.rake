require 'rake'

desc "Runs everyday to close the account for each house"
task :calculate_house_expense, [:processing_date, :house_id] => :environment do |t, args|
  puts "processing_date: #{args[:processing_date]}"
  puts "house_id: #{args[:house_id]}"

  processing_date = Date.strptime(args[:processing_date], '%Y%m%d')

  account_cycle = HouseAccountCycle.where("id = (select to_number(setting_value,'9') from house_settings where setting_name = 'ACCOUNT_CYCLE') and house_id = ?", args[:house_id]).first

  puts "Account close date: #{account_cycle.to_date}"
  if(processing_date == account_cycle.to_date)
  	#Validate all fixed expenses are updated
  	if(HouseExpense.is_all_fixed_expenses_updated?(args[:house_id], account_cycle.id))
  		puts "All fixed exepenses update for the account_cycle: #{account_cycle.id}"
  		puts "delete all the entries from HouseAccountSummary"
  		HouseAccountSummary.where(:house_account_cycle_id => account_cycle.id, :house_id => args[:house_id]).delete_all

  		#Total for account cycle
  		HouseAccountSummary.calculate_total(args[:house_id], account_cycle.id)

  		#Total per tenant
  		HouseAccountSummary.calculate_total_per_tenant(args[:house_id], account_cycle.id)

  		#Total spending by tenant per cycle
  		HouseAccountSummary.calculate_total_spending_by_tenant(args[:house_id], account_cycle.id)
  	end
  end
end