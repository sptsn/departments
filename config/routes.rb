Rails.application.routes.draw do
  resources :employees
  resources :departments, except: :destroy do
    get :new_name
    post :update_name
    get :new_parent
    post :update_parent
  end
  resources :reports, only: :index
end
