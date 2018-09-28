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

    #
    # => add fields to users table
    #
    # config.add_first_name_field =  true

    # config.add_last_name_field =  true

    # config.add_full_name_field =  true

    # config.add_username_field =  true

    # config.add_avatar_fields =  true # Set to false if you have avatar fields for multipart upload photo

    # config.pull_variables_from_facebook = ['avatar', 'first_name', 'last_name', 'username', 'full_name', 'birthday']

    #
    # => add login from social_networks
    #
    # config.include_facebook_login = true

    #
    # => allow to set up in-app class name of user model
    #
    # config.app_user_model_class_name = 'User'
end
