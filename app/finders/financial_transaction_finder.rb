class FinancialTransactionFinder < BaseFinder
  model FinancialTransaction

  def self.search(initial_payment_date: nil,final_payment_date: nil,transaction_type: nil,consolidated: nil, page: nil)
    financial_transactions = FinancialTransaction.all
    financial_transactions = new(financial_transactions).with_payment_date(initial_payment_date,final_payment_date) if initial_payment_date or final_payment_date
    financial_transactions = new(financial_transactions).with_transaction_type(transaction_type) if transaction_type and !transaction_type.blank?
    financial_transactions = new(financial_transactions).with_consolidated(consolidated) if consolidated and !consolidated.blank?
    financial_transactions = new(financial_transactions).paginate(page)
    financial_transactions.includes(:user,:attachments)
  end

  def with_payment_date(initial_payment_date,final_payment_date)
    condition = '1=1 '
    condition += " and payment_date  >= '#{initial_payment_date.to_datetime}' " if initial_payment_date and !initial_payment_date.blank?
    condition += " and payment_date  <= '#{final_payment_date.to_datetime}' " if final_payment_date and !final_payment_date.blank?
    scope.where(condition)
  end

  def with_transaction_type(transaction_type)
    scope.where(transaction_type: transaction_type)
  end

  def with_consolidated(consolidated)
    scope.where(consolidated: consolidated)
  end

end