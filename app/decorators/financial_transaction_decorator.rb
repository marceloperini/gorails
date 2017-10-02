class FinancialTransactionDecorator < Draper::Decorator

  def tr_color
    if object.transaction_type == 'I' and object.consolidated
      'success'
    elsif object.transaction_type == 'O'  and object.consolidated
      'danger'
    elsif !object.consolidated
      'warning'
    end
  end


  def operator
    if object.transaction_type == 'I' and object.consolidated
      '+'
    elsif object.transaction_type == 'O'  and object.consolidated
      '-'
    end
  end
end