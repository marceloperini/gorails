FactoryBot.define do
  factory :social_network do
    link "http://foo.bar.com"

    social_network_type
    user
  end
end
