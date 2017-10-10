class UserDecorator < Draper::Decorator
  delegate_all
  
  def name
    [object.first_name, object.last_name].join(" ").strip
  end

  def email
    h.send(:h, object.email)
  end

  def cover_photo
    object.try(:cover_photo).present? ? object.cover_photo.url : ''
  end

  def user_avatar(css = true, size = nil, tooltip = false)
    html_classes = %W(img-avatar img-avatar#{size} img-avatar-thumb).uniq.join(' ')
    html_attrs   = {}
    html_data    = {}
    avatar_url   = object.try(:avatar).present? ? object.avatar_url : gravatar_url(size)
    html_attrs.update(class: html_classes) if css
    html_data.update(toggle: 'tooltip', placement: 'top') if tooltip
    html_data.update(:'original-title' => object.event_name) if tooltip && object.try(:event_name)
    html_attrs.update(data: html_data) if html_data.present?
    h.image_tag(avatar_url, html_attrs)
  end

  def gravatar_url(size = nil)
    return h.asset_path('user.png') unless object.try(:email).present?

    size        = 64 if size.in?([nil, 'small', :small])
    gravatar_id = Digest::MD5.hexdigest(object.email.downcase)
    host_opts   = configatron.urls.production.to_h.slice(:host, :protocol)
    default_url = h.asset_path('user.png', host_opts)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{default_url}"
  end

  def last_signin_date
    object.last_sign_in_at.strftime('%d/%m/%Y - %H:%M:%S') if object.last_sign_in_at.present?
  end

  def last_signin_ip
    object.last_sign_in_ip if object.last_sign_in_ip.present?
  end

  def link_to_show
    h.link_to h.user_path(id: self.id),
              class: 'tn btn-info btn-sm',
              title: 'Visualizar',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-search' do
      end
    end
  end

  def link_to_edit
    h.link_to h.edit_user_path(id: self.id),
              class: 'tn btn-warning btn-sm',
              title: 'Alterar',
              style: 'color: #FFF; float: none;' do
      h.content_tag :span, class: 'fa fa-pencil' do
      end
    end
  end

  def link_to_delete
    h.link_to h.user_path(id: self.id),
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