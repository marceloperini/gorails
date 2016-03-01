class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 HUMANIZED_ATTRIBUTES = {
:id => "Usuario",
 :email=>"E-mail",
:password=>"Senha",
:password_confirmation=>"Confirmação de Senha",
:remember_me=>"Lembrar-me",
:current_password=>'Senha Atual',
:first_name=>'Primeiro Nome',
:last_name=>'Ultimo Nome'
}
def self.human_attribute_name(attr, vazio=nil)
  HUMANIZED_ATTRIBUTES[attr.to_sym] || super
end

#self.table_name = "tb_usuario"


def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      lista = []
      column_names.each { |coluna| lista << self.human_attribute_name(coluna) }
      csv << lista
      all.each { |registro| csv << registro.attributes.values_at(*column_names) }
    end
    end
end
