class Message
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content

  validates_presence_of :name, :email, :content
end
