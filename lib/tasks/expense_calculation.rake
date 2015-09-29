require 'rake'

desc "Runs everyday to close the account for each house"
task :calculate_house_expense, [:processing_date, :house_id] => :environment do |t, args|
  puts "processing_date: #{args[:processing_date]}"
  puts "house_id: #{args[:house_id]}"

  processing_date = Date.strptime(args[:processing_date], '%Y%m%d')

  account_cycle = HouseAccountCycle.where("id = (select to_number(setting_value,'9') from house_settings where setting_name = 'ACCOUNT_CYCLE') and house_id = ?", args[:house_id]).first

  puts "Account close date: #{account_cycle.to_date}"
  if(processing_date == account_cycle.to_date)
  	puts "*************"
  	
  end
end