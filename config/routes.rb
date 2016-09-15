Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  get 'pages/home'
  root 'pages#home'
end