# == Schema Information
#
# Table name: social_network_types
#
#  id                :integer          not null, primary key
#  name_social_media :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class SocialNetworkType < ApplicationRecord
  has_many :social_networks

  HUMANIZED_ATTRIBUTES = {
      id: "Tipo Rede Social",
      name_social_media: "Nome Rede Social"
  }

  def self.human_attribute_name(attr, vazio=nil)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      lista = []
      column_names.each { |coluna| lista << self.human_attribute_name(coluna) }
      csv << lista
      all.each { |registro| csv << registro.attributes.values_at(*column_names) }
    end
  end

end
