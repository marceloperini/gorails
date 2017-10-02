class FinancialTransactionDecorator < Draper::Decorator
  delegate_all

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

  def transaction_type
    if object.transaction_type == 'I'
      'Renda'
    elsif object.transaction_type == 'O'
      'Despesa'
    end
  end
  def consolidation_date

    h.converte_date(object.consolidation_date) if object.consolidated
  end
end