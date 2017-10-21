require 'carrierwave'

module GoGamification
  module Concerns::Models::Medal
    extend ActiveSupport::Concern

    included do
      belongs_to :goal

      mount_uploader :image, ::GoGamification::ImageUploader
    end
  end
end
