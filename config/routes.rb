Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope "(:locale)", :locale => /en|fr|es|de/ do
    resources :designers, only: [:new, :create] do 
      collection do 
        get :created, :not_created
      end
    end
    root "designers#welcome"
  end
end
