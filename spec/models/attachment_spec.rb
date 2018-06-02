require "rails_helper"

RSpec.describe Attachment, type: :model do
  subject(:attachment) { build(:attachment) }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :type }
  it { is_expected.to respond_to :origin_id }
  it { is_expected.to respond_to :origin_type }
  it { is_expected.to respond_to :situation }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:file) }
end
