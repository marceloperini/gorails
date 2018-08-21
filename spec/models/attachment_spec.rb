# == Schema Information
#
# Table name: attachments
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  type        :string
#  origin_type :string
#  situation   :boolean
#  origin_id   :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  file        :string
#  file_type   :string
#
# Indexes
#
#  index_attachments_on_origin_type_and_origin_id  (origin_type,origin_id)
#

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
