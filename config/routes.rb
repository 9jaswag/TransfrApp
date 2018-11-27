Rails.application.routes.draw do
  resources :uploads, only: [:index, :new, :create, :destroy]

  root to: 'uploads#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
