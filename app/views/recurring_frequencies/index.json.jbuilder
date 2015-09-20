json.array!(@recurring_frequencies) do |recurring_frequency|
  json.extract! recurring_frequency, :id, :frequency, :description
  json.url recurring_frequency_url(recurring_frequency, format: :json)
end
