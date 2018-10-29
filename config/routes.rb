Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: "omniauth_callbacks"}

  root to: "home#index"

  namespace :api do
    namespace :v1 do
      resources :events
    end
  end

  resources :pages, path: 'paginas'

  resources :financial_transactions, path: 'transparencia'
  resources :social_network_types
  resources :winners

  get "activities/index"
  get 'certificado', to: 'users#certified', as: 'certified'
  put 'name_alter', to: 'users#name_alter', as: 'name_alter'
  get 'uf_id_extenso', to: 'users#uf_id_extended', as: 'uf_id_extended'

  resources :images
  resources :albums
  resources :links, path: "links" do
    collection do
      get 'uteis'
    end
  end

  resources :gifts
  resources :link_categories
  resources :partners
  resources :events, path: 'eventos' do
    post :register, on: :member
    collection do
      post 'register'
      get 'index_admin'
      get 'presents'
      get 'user_present_new'
    end
    resources :registrations, controller: 'event_registrations'

  end

  resources :attachments

  resources :users, only: [:show, :index]

  # get "/paginas/:pagina" => "paginas#show"
  get 'contact', to: 'messages#new', as: 'contact'
  post 'messages/subscribe', to: 'messages#subscribe'
  post 'contact', to: 'messages#create'
  match "/404" => "errors#error404", via: [:get, :post, :patch, :delete]
  match "/422" => "errors#error422", via: [:get, :post, :patch, :delete]
  match "/500" => "errors#error500", via: [:get, :post, :patch, :delete]
end
