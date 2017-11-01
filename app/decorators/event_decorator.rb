class EventDecorator < Draper::Decorator
  delegate_all

  def link_to_show
    h.link_to h.event_path(id: self.id),
              class: 'tn btn-info btn-sm',
              title: 'Visualizar',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-search' do
      end
    end
  end

  def link_to_edit
    h.link_to h.edit_event_path(id: self.id),
              class: 'tn btn-warning btn-sm',
              title: 'Alterar',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-pencil' do
      end
    end
  end

  def link_to_delete
    h.link_to h.event_path(id: self.id),
              method: 'delete',
              class: 'tn btn-danger btn-sm',
              title: 'Excluir',
              confirm: 'Deseja realmente excluir o registro?',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-trash-o' do
      end
    end
  end

  def get_event_cover_image
    if self.albums.first
      self.albums.first.images.first.asset.medium.url
    else
      asset_path "bg-red.jpg"
    end
  end

end