Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'pages#home'
  
  resources :users, only: [:index, :show]
  
  #add new resource to allow friendships_controller create, destroy and accept actions
  resources :friendships, only: [:create, :destroy, :accept] do 
    #accept friendship action
    member do 
      put :accept
    end
  end
  
  resources :posts, only: [:create, :edit, :update, :destroy]
  resources :activities, only: [:index]
end