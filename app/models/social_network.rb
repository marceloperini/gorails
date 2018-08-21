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
