Rails.application.routes.draw do
  scope "(:locale)", :locale => /en|fr|es|de/ do
    resources :designers, only: [:new, :create]
    root "designers#welcome"
  end
end
