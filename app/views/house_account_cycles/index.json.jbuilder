json.array!(@house_account_cycles) do |house_account_cycle|
  json.extract! house_account_cycle, :id, :house_id, :from_date, :to_date
  json.url house_account_cycle_url(house_account_cycle, format: :json)
end
