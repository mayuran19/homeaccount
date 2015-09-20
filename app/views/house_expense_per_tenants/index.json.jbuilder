json.array!(@house_expense_per_tenants) do |house_expense_per_tenant|
  json.extract! house_expense_per_tenant, :id, :house_expense_id, :tenant_id, :amount
  json.url house_expense_per_tenant_url(house_expense_per_tenant, format: :json)
end
