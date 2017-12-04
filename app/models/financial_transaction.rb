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

class FinancialTransaction < ApplicationRecord
  belongs_to :user
  has_many :attachments,as: :origin
  accepts_nested_attributes_for :attachments,allow_destroy: true

  def user_name
    self.user.decorate.name if self.user
  end

  def self.income(consolidated=true)
    self.where(transaction_type: 'I',consolidated:consolidated).sum(:value)
  end

  def self.outcome(consolidated=true)
    self.where(transaction_type: 'O',consolidated:consolidated).sum(:value)
  end

  def self.balance
    income - outcome
  end

  def self.balance_after_consolidated
    (income+income(false)) - (outcome + outcome(false))
  end
end
