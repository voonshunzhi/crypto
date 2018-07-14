Rails.application.routes.draw do
  devise_for :users
  resources :cryptocurrencies
  root 'home#index'
  get 'about' => 'home#about'
  get 'lookup' => 'home#lookup'
  post 'lookup' => 'home#lookup'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
