Rails.application.routes.draw do
  mount ApiAuthentication::Engine => '/api'
end
