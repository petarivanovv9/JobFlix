Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'

  devise_for :user,
             :path => '',
             :path_names => { :sign_in => 'login',
                              :sign_out => 'logout',
                              :sign_up => 'register'}

  get '/job_offers', to: 'job_offers#index'
  get '/job_offers/:identificator', to: 'job_offers#show', :identificator => /[^\/]+/
  get '/job_offers/:identificator/:user_id', to: 'job_offers#show', :identificator => /[^\/]+/
  # match '/job_offers/:identificator/:user_id/like', via: :post, to: 'job_offers#like_job_offer', :identificator => /[^\/]+/
  post '/job_offers/:identificator/:user_id/like', to: 'job_offers#like_job_offer', :identificator => /[^\/]+/
  # post '/job_offers/:name/like', to: 'job_offers#like_job_offer', :name => /[^\/]+/



end
