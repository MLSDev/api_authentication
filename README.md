[![Build Status](https://travis-ci.org/MLSDev/api_authentication.svg?branch=master)](https://travis-ci.org/MLSDev/api_authentication)

# ApiAuthentication

ApiAuthentication.

Only Rails `> 5` support.

## Installation

Add these gems to your Gemfile

``` ruby
gem 'api_authentication', github: 'MLSDev/api_authentication', tag: 'LATEST_VERSION'

gem 'geocoder'

gem 'paperclip'
```

Install ImageMagic

```brew install imagemagick```

...and run `bundle install` to install the gems.

Next, run:

``` bash
# add an initializer to config/initializers with all of the configuration options
rails g api_authentication:install

# This will add the necessary migrations to your app's db/migrate directory
rails g api_authentication:migrations

# This will run any pending migrations
rails db:migrate
```

Include module to Your `BaseController`:

```ruby
include ApiAuthentication::ActsAsBaseControllerWithAuthentication
```

then add to `.env` file `JWT_HMAC_SECRET` variable and assign some value to it

then add the following to your routes.rb file:

``` bash
# config/routes.rb
mount ApiAuthentication::Engine => '/api'

# or inside api namespace

namespace :api do
  mount ApiAuthentication::Engine => '/'
end
```

It will generate routes like

```
Routes for ApiAuthentication::Engine:
session          PATCH  /session
                 PUT    /session
                 POST   /session
                 DELETE /session
facebook_session POST   /facebook/session
```

### SWAGGER

Add in SWAGGERED_CLASSES array in api docs controller of project (if swagger gem is used in project)

`ApiAuthentication::SWAGGER_CLASSES`

And call on array `flatten` method like this

```
SWAGGERED_CLASSES = [
    SomeClass,
    ApiAuthentication::SWAGGER_CLASSES,
  ].flatten.freeze
```

## About MLSDev

![MLSdev][logo]

The repo is maintained by MLSDev, Inc. We specialize in providing all-in-one solution in mobile and web development. Our team follows Lean principles and works according to agile methodologies to deliver the best results reducing the budget for development and its timeline.

Find out more [here][mlsdev] and don't hesitate to [contact us][contact]!

[mlsdev]:  https://mlsdev.com
[contact]: https://mlsdev.com/contact_us
[logo]:    https://raw.githubusercontent.com/MLSDev/development-standards/master/mlsdev-logo.png "Mlsdev"






