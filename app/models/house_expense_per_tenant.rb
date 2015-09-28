class HouseExpensePerTenant < ActiveRecord::Base
  belongs_to :tenant
  belongs_to :house_expense
end
