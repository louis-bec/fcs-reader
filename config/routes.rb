Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'welcome/index'
  # TODO: could have some special option for show action, like singular?
  resources :fcs_files, only: [:index, :new, :show, :create, :destroy]
  resources :s3_files, only: [:index, :new, :create]
  get 's3_file/show', to: 's3_files#show'
  get 's3_file/delete', to: 's3_files#destroy'
  get 's3_file/download', to: 's3_files#download'
end
