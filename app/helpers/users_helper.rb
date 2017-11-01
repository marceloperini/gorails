module UsersHelper
  def class_fa(type_id)
    case type_id
      when 1
        return 'facebook-official'
      when 2
        return 'google-plus'
      when 3
        return 'twitter'
      when 4
        return 'instagram'
      when 5
        return 'linkedin'
      when 6
        return 'snapchat'
      when 7
        return 'youtube'
      when 8
        return 'github'
      when 9
        return 'reddit'
      when 10
        return 'twitch'
      when 11
        return 'stack-overflow'
      when 12
        return 'user'
    end

  end
end

