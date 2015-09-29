class HouseExpenseTemplate < ActiveRecord::Base
  belongs_to :frequency, :class_name => RecurringFrequency, :foreign_key => 'recurring_frequency_id'
  belongs_to :default_payee, :class_name => Tenant, :foreign_key => 'default_payee_id'
end
