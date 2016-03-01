Rails.application.routes.draw do

  resources :tb_eventos,:path=>'eventos'

  devise_for :users
  get "/paginas/:pagina" => "paginas#show"
  root "paginas#show", pagina: "home"
end
