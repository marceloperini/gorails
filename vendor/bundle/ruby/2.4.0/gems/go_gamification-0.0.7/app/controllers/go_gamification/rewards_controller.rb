require_dependency "go_gamification/application_controller"

module GoGamification
  class RewardsController < ApplicationController
    include GoGamification::Concerns::Controllers::RewardsController
  end
end
