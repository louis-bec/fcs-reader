Rails.application.routes.draw do
  get 'fcs_files/index'
  get 'fcs_files/new'
  get 'fcs_files/create'
  get 'fcs_files/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/index'
  post 'welcome/upload'
end
