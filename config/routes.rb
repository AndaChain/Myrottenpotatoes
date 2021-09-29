Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  post '/movies/search_tmdb' # Route that posts 'Search TMDb' form
  
  root :to => redirect('/movies')
  
  resources :movies do
    resources :reviews
  end
  
  get  'auth/:provider/callback' => 'sessions#create'
  # get '/auth/:provider/callback' => 'sessions#omniauth'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  get  'auth/google_auth2', :as => 'login'

end
