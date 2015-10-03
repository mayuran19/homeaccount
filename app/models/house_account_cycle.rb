class HouseAccountCycle < ActiveRecord::Base
	def self.move_to_next_account_cycle(house_id)
		current_cycle = self.get_current_account_cycle(house_id)
		house = House.find(house_id)
		default_cycle_date = house.default_account_cycle_date

		#Move to next month
		new_house_account_cycle = HouseAccountCycle.new
		new_house_account_cycle.house_id = house_id
		new_house_account_cycle.from_date = current_cycle.to_date
		new_house_account_cycle.to_date = current_cycle.to_date + 1.months
		new_house_account_cycle.save

		#Update the house_settings table with new house_account_cycle_id
		house_setting = HouseSetting.get_current_account_cycle_setting(house_id)
		house_setting.setting_value = new_house_account_cycle.id.to_s
		house_setting.save
	end

	def self.get_current_account_cycle(house_id)
		current_account_cycle = HouseAccountCycle.where("id = (select to_number(setting_value,'9') from house_settings where setting_name = 'ACCOUNT_CYCLE') and house_id = ?", house_id).first
	end

	def self.get_last_account_cycle(house_id)
		last_cycle = HouseAccountCycle.where(["id =(select max(house_account_cycle_id) from house_account_summaries where house_id = ?)",house_id]).first
	end
end
