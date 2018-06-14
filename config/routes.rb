Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'home#index' #get '/' => 'home#index'
    get '/lunch' => 'home#menu'
    
    get '/users' => 'user#index'
    get '/user/new' => 'user#new'
    get '/user/:id' => 'user#show'
    post '/user/create' => 'user#create'
  
    get '/lotto' => 'lotto#index'
    get '/lotto/new' => 'lotto#new'
  
end