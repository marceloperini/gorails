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

  def link_to_visualizar
    h.link_to h.financial_transaction_path(id: self.id),
              class: 'tn btn-info btn-sm',
              title: 'Visualizar',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-search' do
      end
    end
  end

  def link_to_editar
    h.link_to h.edit_financial_transaction_path(id: self.id),
              class: 'tn btn-warning btn-sm',
              title: 'Alterar',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-pencil' do
      end
    end
  end

  def link_to_excluir
    h.link_to h.financial_transaction_path(id: self.id),
              method: 'delete',
              class: 'tn btn-danger btn-sm',
              title: 'Excluir',
              confirm: 'Deseja realmente excluir o registro?',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-trash-o' do
      end
    end
  end
end