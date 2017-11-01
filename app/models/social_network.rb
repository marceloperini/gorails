class SocialNetwork < ActiveRecord::Base
  belongs_to :social_network_type
  belongs_to :user

  validates_presence_of :link, :social_network_type_id


  HUMANIZED_ATTRIBUTES = {
      id: "Rede Social",
      link: "Link da Rede Social",
      social_network_type_id: "Tipo Rede Social"
  }

  def self.human_attribute_name(attr, vazio=nil)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      lista = []
      column_names.each {|coluna| lista << self.human_attribute_name(coluna)}
      csv << lista
      all.each {|registro| csv << registro.attributes.values_at(*column_names)}
    end
  end

end
