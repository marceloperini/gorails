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
