json.array!(@users) do |user|
  json.extract! user, :id, :name, :birthdate, :address, :credit_card, :phone, :email, :password, :confirmed, :newsletter
  json.url user_url(user, format: :json)
end
