class TbUsuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
auditable
 HUMANIZED_ATTRIBUTES = {
:id => "Usuario"
}
def self.human_attribute_name(attr, vazio=nil)
  HUMANIZED_ATTRIBUTES[attr.to_sym] || super
end

self.table_name = "sch_.tb_usuario"




RELATORIO_USUARIO_TITULO = ["Relatórios Usuario"]
RELATORIO_USUARIO_TITULOS = []
RELATORIO_USUARIO_CAMPOS = []


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      lista = []
      column_names.each { |coluna| lista << self.human_attribute_name(coluna) }
      csv << lista
      all.each { |registro| csv << registro.attributes.values_at(*column_names) }
    end
    end
end
