Rails.application.routes.draw do
  resources :questions do
    resources :quotations
    resources :supports
  end
end
