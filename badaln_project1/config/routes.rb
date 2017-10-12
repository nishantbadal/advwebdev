Rails.application.routes.draw do
  root 'links#index'
  resources :links
  
  get 'links/go/:id' => 'links#go'
  post 'links/new' => 'links#create'
    
  get 'admin', :to => 'access#menu'
  get 'access/menu'
  get 'access/login'
  get 'access/signup'
  post 'access/signupAttempt'
  post 'access/attempt'
  get 'access/logout'
  get 'help', :to => 'access#help'
  get 'access/help'
  get 'users/' => 'users#show'
    

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
    
    
end
