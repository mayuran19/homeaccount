json.array!(@house_settings) do |house_setting|
  json.extract! house_setting, :id, :house_id, :setting_name, :setting_value
  json.url house_setting_url(house_setting, format: :json)
end
