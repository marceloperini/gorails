module GoGamification::Concerns::Rewarding
  extend ActiveSupport::Concern

  included do
    has_many :goals, class_name: '::GoGamification::Goal', as: :rewarding
  end
end
