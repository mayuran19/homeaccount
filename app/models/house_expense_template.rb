class HouseExpenseTemplate < ActiveRecord::Base
  belongs_to :frequency, :class_name => RecurringFrequency, :foreign_key => 'recurring_frequency_id'
end
