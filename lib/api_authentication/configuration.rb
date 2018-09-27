module ApiAuthentication
  class Configuration
    include ActiveSupport::Configurable

    #
    # => Controller that should be inherited by engine ApplicationController, default is 'ActionController::Base'
    #
    config_accessor(:controller_to_inherit_from) { 'ActionController::Base' }

    #
    # => Table name of User model, default is `users`
    #
    config_accessor(:users_table_name)       { 'users' }

    #
    # => add fields to users table
    #

    config_accessor(:add_first_name_field)   { true }

    config_accessor(:add_last_name_field)    { true }

    config_accessor(:add_full_name_field)    { true }

    config_accessor(:add_username_field)     { true }

    config_accessor(:add_birthday_field)     { true }

    config_accessor(:add_avatar_fields)      { true }

    config_accessor(:pull_variables_from_facebook) { ['avatar', 'first_name', 'last_name', 'username', 'full_name', 'birthday'] }

    #
    # => add login from sicial_networks
    #

    config_accessor(:include_facebook_login) { true }

    #
    # => allow to set up in-app class name of user model
    #

    config_accessor(:app_user_model_class_name) { 'User' }

  end
end
