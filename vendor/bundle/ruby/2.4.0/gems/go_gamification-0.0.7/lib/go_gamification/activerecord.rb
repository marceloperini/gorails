module GoGamification::ActiveRecord
  module Extensions
    def rewarding
      include GoGamification::Concerns::Rewarding
    end

    def rewardable
      include GoGamification::Concerns::Rewardable
    end
  end
end

::ActiveRecord::Base.send :extend, GoGamification::ActiveRecord::Extensions if defined?(ActiveRecord)