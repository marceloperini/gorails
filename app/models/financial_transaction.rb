class FinancialTransaction < ApplicationRecord
  has_many :attachments, as: :origin

  belongs_to :user

  accepts_nested_attributes_for :attachments, allow_destroy: true

  def self.income(consolidated = true)
    self.where(transaction_type: 'I', consolidated: consolidated).sum(:value)
  end

  def self.outcome(consolidated = true)
    self.where(transaction_type: 'O', consolidated: consolidated).sum(:value)
  end

  def self.balance
    income - outcome
  end

  def self.balance_after_consolidated
    (income + income(false)) - (outcome + outcome(false))
  end

  def user_name
    self.user.decorate.name if self.user
  end
end
