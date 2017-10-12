class UserFinder < BaseFinder
  model User

  def self.search(first_name: nil,email: nil,provider: nil, page: nil)
    users = User.all
    users = new(users).with_first_name(first_name) if first_name and !first_name.blank?
    users = new(users).with_email(email) if email and !email.blank?
    users = new(users).with_provider(provider) if provider and !provider.blank?
    users = new(users).paginate(page)
    users
  end

  def with_first_name(first_name)
    scope.where('first_name LIKE ?',"%#{first_name}%")
  end

  def with_email(email)
    scope.where(email: email)
  end

  def with_provider(provider)
    scope.where(provider: provider)
  end

end