Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'

  devise_for :user,
             :path => '',
             :path_names => { :sign_in => 'login',
                              :sign_out => 'logout',
                              :sign_up => 'register'}

  get '/job_offers', to: 'job_offers#index'
  get '/job_offers/:id', to: 'job_offers#show'
  get '/job_offers/:id/:user_id', to: 'job_offers#show'

  post '/job_offers/:id/:user_id/like', to: 'job_offers#like_job_offer'

  # , :identificator => /[^\/]+/


end
