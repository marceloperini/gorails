class UserDecorator < Draper::Decorator
  delegate_all

  def inventory?
    Gamification::Inventory.where(user_id:id).any?
  end

  def owner?
    inventory? && h.current_user == self
  end

  def name
    return 'Usuário' if !first_name.present? and !last_name.present?
    [object.first_name, object.last_name].join(" ").strip
  end

  def equipped_hair
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'hair'})
                     .joins(:inventories, :item_type).first.image
  end

  def equipped_head
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'head'})
                     .joins(:inventories, :item_type).first.image
  end

  def equipped_left_arm
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'leftarm'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_right_arm
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'rightarm'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_legs
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'legs'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_torso
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'torso'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_right_arm_jump
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'rightarmjump'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_left_arm_jump
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'leftarmjump'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_legs_jump
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'legsjump'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_background
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'background'})
                     .joins(:inventories, :item_type).first.image
  end
  def equipped_flyingobject
    h.asset_path Gamification::Item.where(gamification_inventories: {equipped: true,user_id:id}, gamification_item_types: {key: 'flyingobject'})
                     .joins(:inventories, :item_type).first.image
  end

  def xp_percent
    if current_experience > 0 and next_level_xp > 0
      current_experience * 100 / next_level_xp
    else
      1
    end
  end

  def email
    h.send(:h, object.email)
  end

  def cover_photo
    object.try(:cover_photo).present? ? object.cover_photo.url : ''
  end

  def user_avatar(css = true, size = nil, tooltip = false)
    html_classes = %W(img-avatar img-avatar#{size} img-avatar-thumb).uniq.join(' ')
    html_attrs = {}
    html_data = {}
    avatar_url = object.try(:avatar).present? ? object.avatar_url : gravatar_url(size)
    html_attrs.update(class: html_classes) if css
    html_data.update(toggle: 'tooltip', placement: 'top') if tooltip
    html_data.update(:'original-title' => object.event_name) if tooltip && object.try(:event_name)
    html_attrs.update(data: html_data) if html_data.present?
    h.image_tag(avatar_url, html_attrs)
  end

  def gravatar_url(size = nil)
    return h.asset_path('user.png') unless object.try(:email).present?

    size = 64 if size.in?([nil, 'small', :small])
    gravatar_id = Digest::MD5.hexdigest(object.email.downcase)
    host_opts = configatron.urls.production.to_h.slice(:host, :protocol)
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