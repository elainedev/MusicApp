Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show]
  # :users matches controller name

  resource :sessions, only: [:new, :create, :destroy]
  # singular resource b/c only 1 session per user.  Thus can't call sessions/id b/c no distinct ids for session.
  # so to destroy, just send session, not session/id to delete
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:index, :new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:index, :new]
end
