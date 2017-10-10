Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations',
                                    omniauth_callbacks: 'omniauth_callbacks' }

  root to: 'home#index'

  resources :pages, path: 'paginas'

  resources :financial_transactions, path: 'transparencia'
  resources :social_network_types
  resources :winners

  resources :images
  resources :albums

  resources :links, path: 'links' do
    get 'uteis', on: :collection
  end

  resources :gifts
  resources :link_categories
  resources :partners

  resources :events, path: 'eventos' do
    post :register, on: :member
    post :register, on: :collection

    resources :registrations, controller: 'event_registrations'
  end

  resources :attachments
  resources :users, only: [:show, :index]

  get 'activities/index'

  # get "/paginas/:pagina" => "paginas#show"
  get 'contact', to: 'messages#new', as: 'contact'
  post 'messages/subscribe', to: 'messages#subscribe'
  post 'contact', to: 'messages#create'
  match '/404' => 'errors#error404', via: [:get, :post, :patch, :delete]
  match '/422' => 'errors#error422', via: [:get, :post, :patch, :delete]
  match '/500' => 'errors#error500', via: [:get, :post, :patch, :delete]
end
