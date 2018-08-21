# == Schema Information
#
# Table name: social_networks
#
#  id                     :bigint(8)        not null, primary key
#  user_id                :bigint(8)
#  link                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  social_network_type_id :bigint(8)
#
# Indexes
#
#  index_social_networks_on_social_network_type_id  (social_network_type_id)
#  index_social_networks_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (social_network_type_id => social_network_types.id)
#  fk_rails_...  (user_id => users.id)
#

require "rails_helper"

RSpec.describe SocialNetwork, type: :model do
  subject(:social_network) { build(:social_network) }

  it { is_expected.to respond_to :link }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:social_network_type) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:link) }
  it { is_expected.to validate_presence_of(:social_network_type_id) }

  describe "when :link haven't a link format" do
    let(:incorrect_links) { %w(foo.bar htp://foo foo.br) }

    it "social_network is not valid" do
      incorrect_links.each do |link|
        social_network.link = link

        expect(social_network).not_to be_valid
      end
    end
  end
end
