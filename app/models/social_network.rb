class SocialNetwork < ActiveRecord::Base
  belongs_to :social_network_type
  belongs_to :user

  validates_presence_of :link, :social_network_type_id

  validate :validate_link_social

  HUMANIZED_ATTRIBUTES = {
    id: "Rede Social",
    link: "Link da Rede Social",
    social_network_type_id: "Tipo Rede Social"
  }.freeze

  def self.human_attribute_name(attr, vazio=nil)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def validate_link_social
    return if link.nil?

    unless self.link.include?('http://') || self.link.include?('https://') || self.link.include?('.com') || self.link.include?('www.')
      errors.add(:link, 'Digite o Link Completo da Rede Social')
    end
  end
end
