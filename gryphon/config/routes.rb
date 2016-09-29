Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'

  devise_for :user,
             :path => '',
             :path_names => { :sign_in => 'login',
                              :sign_out => 'logout',
                              :sign_up => 'register'}

  get '/job_offers/:name', to: 'job_offers#show', :name => /[^\/]+/
  get '/job_offers/', to: 'job_offers#index'
  post '/job_offers/:name/like', to: 'job_offers#like_job_offer', :name => /[^\/]+/

end
