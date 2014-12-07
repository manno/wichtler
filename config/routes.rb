Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'admin/dashboard#index'

  get 'confirm/:code', controller: 'public', action: 'confirm', as: :public_confirm

end
