Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/index'
  # TODO: could have some special option for show action, like singular?
  resources :fcs_files, only: [:index, :new, :show, :create, :destroy]
end
