class FinancialTransaction < ApplicationRecord
  belongs_to :user

  def user_name
    self.user.decorate.name if self.user
  end
end
