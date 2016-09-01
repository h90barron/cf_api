require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  #devise_for :users
  
  namespace :api, defaults: { format: :json } do
                            #constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1, 
      constraints: ApiConstraints.new(version: 1, default: true) do
        
     resources :users, :only => [:show, :create, :update]   
        
    end
  end
end
