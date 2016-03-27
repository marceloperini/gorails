class UserPresenter < Burgundy::Item

  def user_avatar(css=true)
    if item.avatar.present?
      h.image_tag(item.avatar.url, class: css ? "img-avatar img-avatar96 img-avatar-thumb" : ""  )
    else
      h.image_tag(avatar_url(item), class: css ? "img-avatar img-avatar96 img-avatar-thumb" : "" )
    end
  end


  def avatar_url(user)
      default_url = "user.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=200&d=#{CGI.escape(default_url)}"
  end

end