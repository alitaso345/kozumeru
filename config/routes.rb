Rails.application.routes.draw do
  root :to => 'maids#index'
  resources :maids
end
