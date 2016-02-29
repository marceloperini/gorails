Rails.application.routes.draw do
  devise_for :tb_usuarios
  get "/paginas/:pagina" => "paginas#show"
  root "paginas#show", pagina: "home"
end
