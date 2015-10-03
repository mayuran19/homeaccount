class HouseExpenseTemplate < ActiveRecord::Base
  belongs_to :frequency, :class_name => RecurringFrequency, :foreign_key => 'recurring_frequency_id'
  belongs_to :default_payee, :class_name => Tenant, :foreign_key => 'default_payee_id'

  def self.fixed_expenses_by_house_id(house_id)
  	HouseExpenseTemplate.where(:house_id => house_id)
  end

  def self.fixed_expenses_not_paid_for_current_cycle(house_id)
  	HouseExpenseTemplate.where("house_id = ? and id not in(select house_expense_template_id from house_expenses where house_id = ? and house_account_cycle_id = (select to_number(setting_value,'9') from house_settings where setting_name = 'ACCOUNT_CYCLE' and house_id = ?) and house_expense_template_id is not null)", house_id, house_id, house_id)
  end
end
