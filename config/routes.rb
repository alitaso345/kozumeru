Rails.application.routes.draw do
  root :to => 'maids#index'
  resources :maids, :only => ['index', 'show', 'edit'] do
    resources :tweets, :only => ['index']
    resources :pictures, :only => ['index']
  end
end
