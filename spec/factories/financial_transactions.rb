FactoryGirl.define do
  factory :financial_transaction do
    object "MyString"
    origin "MyString"
    transaction_type "MyString"
    value "MyString"
    user_id 1
    payment_date "MyString"
    payment_method "MyString"
    consolidated false
    consolidation_date "MyString"
  end
end
