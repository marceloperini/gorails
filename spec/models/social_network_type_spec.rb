# == Schema Information
#
# Table name: social_network_types
#
#  id                :bigint(8)        not null, primary key
#  name_social_media :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require "rails_helper"

RSpec.describe SocialNetworkType, type: :model do
  subject { build(:social_network_type) }

  it { is_expected.to respond_to(:name_social_media) }

  it { is_expected.to be_valid }

  it { is_expected.to have_many(:social_networks) }

  it { is_expected.to validate_presence_of(:name_social_media) }
end
