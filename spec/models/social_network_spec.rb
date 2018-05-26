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
