# These configuration options can be used to customise the behaviour of ApiAuthentication
ApiAuthentication.configure do |config|
  #
  # => Controller that should be inherited by engine ApplicationController, default is 'ActionController::Base'
  #
  # config.controller_to_inherit_from = 'ActionController::Base'

  #
  # => Table name of User model, default is `users`
  #
  # config.users_table_name =  'users'

  # => add login from social_networks
  #
  # config.include_facebook_login = true

  #
  # => allow to set up in-app class name of user model
  #
  # config.app_user_model_class_name = 'User'
  # config.app_refresh_token_model_class_name = 'RefreshToken'

  # config.jwt_token_exp = 1.hour.from_now
  # config.include_refresh_token = false
  # config.refresh_token_exp = 1.month.from_now
end
