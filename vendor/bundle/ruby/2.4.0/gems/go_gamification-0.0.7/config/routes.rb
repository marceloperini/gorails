Rails.application.routes.draw do
    resources :rewards, only: [:create]
end
