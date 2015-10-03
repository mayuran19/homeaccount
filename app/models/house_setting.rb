class HouseSetting < ActiveRecord::Base
	def self.get_current_account_cycle_setting(house_id)
		house_setting = HouseSetting.where(:house_id => house_id, :setting_name => 'ACCOUNT_CYCLE').first

		house_setting
	end
end
