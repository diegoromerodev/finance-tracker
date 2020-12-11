Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'stocks/search', to: 'stocks#search'
  get 'friends', to: 'users#friends'
  get 'search_friends', to: 'users#search'
  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]
end
