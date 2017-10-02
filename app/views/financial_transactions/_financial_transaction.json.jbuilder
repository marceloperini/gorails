json.extract! financial_transaction, :id, :object, :origin, :transaction_type, :value, :user_id, :payment_date, :payment_method, :consolidated, :consolidation_date, :created_at, :updated_at
json.url financial_transaction_url(financial_transaction, format: :json)
