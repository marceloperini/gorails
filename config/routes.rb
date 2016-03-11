Rails.application.routes.draw do
  resources :link_categories
  resources :events, :path => 'eventos' do
  	post :register, on: :member
    collection do
      get 'register'
    end
  end
  devise_for :users, :controllers => {registrations: 'registrations'}
  get "/paginas/:pagina" => "paginas#show"
  root "paginas#show", pagina: "home"
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'
end
