class UserPresenter < Burgundy::Item
  def description
    if item.description.present?
      h.content_tag(:p, item.description, class: "description")
    end
  end

  def checkout_partial
    item.paid? ? "order" : "download"
  end

  def user_avatar
    if item.avatar.present?
      h.image_tag(item.avatar.url, class: "img-avatar img-avatar96 img-avatar-thumb")
    else
      h.image_tag("user.png", class: "img-avatar img-avatar96 img-avatar-thumb")
    end
  end

end