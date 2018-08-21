# == Schema Information
#
# Table name: social_network_types
#
#  id                :bigint(8)        not null, primary key
#  name_social_media :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class SocialNetworkType < ApplicationRecord
  has_many :social_networks

  validates_presence_of :name_social_media

  HUMANIZED_ATTRIBUTES = {
    id: "Tipo Rede Social",
    name_social_media: "Nome Rede Social"
  }.freeze

  def self.human_attribute_name(attr, vazio=nil)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end
