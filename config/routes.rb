Rails.application.routes.draw do
  
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  namespace :api do
    namespace :v1 do
      resources :campaigns do 
        resources :comments
      end
    end
  end

  get '/members' => 'members#index'

end
