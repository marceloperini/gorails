class UserPresenter < Burgundy::Item

  def user_avatar(css=true,size="")
    if item.avatar.present?
      h.image_tag(item.avatar.url, class: css ? "img-avatar img-avatar#{size} img-avatar-thumb" : ""  )
    else
      h.image_tag(gravatar_url(item), class: css ? "img-avatar img-avatar#{size} img-avatar-thumb" : "" )
    end
  end


  def gravatar_url(user)
      default_url = "http://www.gorails.com.br/#{ h.asset_path 'user.png'}"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=200&d=#{default_url}"
  end

end