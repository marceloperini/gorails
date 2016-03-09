FactoryGirl.define do
  factory :attachment do
    name 'file'
    file_type 'png'
    data '../Imagens/logo.png'
    situation true
    origin_type 'partners'
  end
end