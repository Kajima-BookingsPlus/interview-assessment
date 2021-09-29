json.extract! confirmation, :id, :booking_id, :send_confirmation_msg, :type, :created_at, :updated_at
json.url confirmation_url(confirmation, format: :json)
