require "rails_helper"

RSpec.describe SocialNetworkType, type: :model do
  subject { build(:social_network_type) }

  it { is_expected.to respond_to(:name_social_media) }

  it { is_expected.to be_valid }

  it { is_expected.to have_many(:social_networks) }

  it { is_expected.to validate_presence_of(:name_social_media) }
end
