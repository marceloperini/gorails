# == Schema Information
#
# Table name: financial_transactions
#
#  id                 :integer          not null, primary key
#  object             :string
#  origin             :string
#  transaction_type   :string(1)
#  value              :decimal(13, 2)
#  user_id            :integer
#  payment_date       :datetime
#  payment_method     :string
#  consolidated       :boolean          default(FALSE), not null
#  consolidation_date :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_financial_transactions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do # frozen_string_literal: true.
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
