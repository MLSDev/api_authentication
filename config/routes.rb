ApiAuthentication::Engine.routes.draw do
  resource :session, only: [:create, :update, :destroy]

  namespace :facebook do
    resource :session, only: :create
  end
end
