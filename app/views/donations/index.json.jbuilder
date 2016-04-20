json.array!(@donations) do |donation|
  json.extract! donation, :id, :name, :amount, :type, :date, :receipt_title, :receipt_address, :phone, :email
  json.url donation_url(donation, format: :json)
end
