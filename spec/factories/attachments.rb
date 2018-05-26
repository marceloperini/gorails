FactoryBot.define do # frozen_string_literal: true.
  factory :attachment do
    name "Filename"
    situation true
    file File.open(File.join(Rails.root, "/spec/fixtures/files/image.png"))
  end
end
