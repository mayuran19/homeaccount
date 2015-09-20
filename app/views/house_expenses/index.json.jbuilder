json.array!(@house_expenses) do |house_expense|
  json.extract! house_expense, :id, :tenant_id, :house_expense_template_id, :expense_name, :house_id, :amount, :spent_date
  json.url house_expense_url(house_expense, format: :json)
end
