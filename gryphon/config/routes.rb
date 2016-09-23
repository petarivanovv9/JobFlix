Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'

  devise_for :user,
             :path => '',
             :path_names => { :sign_in => 'login',
                              :sign_out => 'logout',
                              :sign_up => 'register'}

end
