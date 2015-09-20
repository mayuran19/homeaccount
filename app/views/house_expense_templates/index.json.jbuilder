json.array!(@house_expense_templates) do |house_expense_template|
  json.extract! house_expense_template, :id, :expense_name, :house_id, :recurring_frequency_id, :recurring_frequency_value, :effective_from, :effective_to, :is_mandatory, :default_amount
  json.url house_expense_template_url(house_expense_template, format: :json)
end
