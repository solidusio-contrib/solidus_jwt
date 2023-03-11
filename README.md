SolidusJwt
==========

[![Gem Version](https://badge.fury.io/rb/solidus_jwt.svg)](https://badge.fury.io/rb/solidus_jwt)

This gem gives [Solidus](https://github.com/solidusio/solidus) stores the ability to authenticate API requests with
JSON Web Tokens.

To use this gem, you should have a sound understanding of **JSON web tokens**. For more information you can visit the [**Offical JWT Website**](https://jwt.io/introduction/). It may also be useful to look at [**ruby-jwt**](https://github.com/jwt/ruby-jwt), the library required by this gem.


Installation
------------

Add solidus_jwt to your Gemfile:

```ruby
gem 'solidus'
gem 'solidus_jwt'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g solidus_jwt:install
```

Configuration
-------------
```ruby
# config/initializers/solidus_jwt.rb

SolidusJwt::Config.configure do |config|
  config.jwt_secret           = 'secret'
  config.allow_spree_api_key  = true
  config.jwt_algorithm        = 'HS256'
  config.jwt_expiration       = 3_600
  config.jwt_options          = { only: %i[email first_name id last_name] }
  config.refresh_expiration   = 2_592_000
end
```

#### `jwt_secret`:
Defaults to `Rails.application.secret_key_base`. The encryption key, should be kept secret and secure.

#### `allow_spree_api_key`:
Defaults to `true`. When true, the `spree_api_key` is still accepted as an authentication token along with json web tokens.

#### `jwt_algorithm`:
Defaults to `HS256`. See: https://github.com/jwt/ruby-jwt#algorithms-and-usage for more information on accepted algorithms.

#### `jwt_expiration`:
Defaults to `3600` (1 hour). The amount of time in seconds that the token should last for.

#### `jwt_options`
Defaults to `{ only: %i[email first_name id last_name] }`. These options are passed into `Spree::User#as_json` when serializing the token's payload.  Keep in mind that the more information included, the larger the token will be. It may be in your best interest to keep it short and simple.

#### `refresh_expiration`:
Defaults to `2592000` (30 days). The amount of time in seconds that the token should last for. Optionally, this may be set to nil so that refresh tokens never expire

Usage
-------------
### Generating and decoding a token:

```ruby
SolidusJwt::Config.configure do |config|
  config.jwt_secret = 'secret'
end

user = Spree::User.new email: 'email@example.com', id: 1
token = user.generate_jwt_token(expires_in: 1.hour.to_i) # Expiration is time in seconds
# eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZW1haWwiOiJlbWFpbEBleGFtcGxlLmNvbSIsInN1YiI6MSwiZXhwIjoxNTcyNTg2NTA3LCJpYXQiOjE1NzI1ODI5MDcsImlzcyI6InNvbGlkdXMifQ.UEmPLClCmOii_5-Qa6fB_ToGavIJYY6PAyfhARitMwI

SolidusJwt.decode(token)
# [
#   {
#     "id"=>1, 
#     "email"=>"email@example.com", 
#     "sub"=>1, 
#     "exp"=>1572586507, 
#     "iat"=>1572582907, 
#     "iss"=>"solidus"
#   },
#   {"alg"=>"HS256"}
# ]
```

### Autenticate through the API

If authenticating through the API, you must have 
[solidus_auth_devise](https://github.com/solidusio/solidus_auth_devise) setup
because `solidus_jwt` piggybacks off of the [Devise](https://github.com/plataformatec/devise) 
gem. This enables authentication through a single point. If you implement 
[Devise Lockable](https://www.rubydoc.info/github/plataformatec/devise/master/Devise/Models/Lockable), 
then locking is respected both on the front-end as well as on the API.

```ruby
POST /oauth/token
{
  "username": "user@example.com"
  "password": "secret"
  "grant_type": "password"
}

# { "access_token": "abc.123.efg", "refresh_token": "123456" }
```

You can now use the `access_token` to authentication with the 
[Solidus API](https://github.com/solidusio/solidus/tree/master/api) in place
of the `spree_api_key`.

#### Matching token to a user

By default, the token matches a user using the `Spree::User.for_jwt` method. This methods
Finds a user by id using the subject claim of the token. If you want to customize how the
subject claim is interpreted you can override this method

```ruby
def self.for_jwt(sub)
  # find_by(id: sub)
  find_by(my_external_id: sub)
end
```

### Obtain a refresh token

To refresh your access token, instead of re-authenticating you can send
a refresh token.

```ruby
POST /oauth/token
{
  "refresh_token": "123456"
  "grant_type": "refresh_token"
}

# { "access_token": "hij.456.klm", "refresh_token": "789abc" }
```

### Invalidate refresh tokens for a user

It is good practice set the lifetime of an access token to be short. In case an
access token is compromised, the attacker will only have access for a short time.

To force a user to have to reauthencate rather than using a refresh token,
you can do the following:

```ruby
# Invalidate all refresh tokens for a user
SolidusJwt::Token.invalidate(user)
```

### Distributing a Token Using 'solidus_auth_devise' on front-end:

To have the `solidus_auth_devise` gem distribute a token back to the client
you can do the following:
```ruby
# app/controllers/application_controller.rb
include SolidusJwt::Distributor::Devise
```

When a user logs in, the redirect will contain the header `X-SPREE-TOKEN`.

Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs, and [Rubocop](https://github.com/bbatsov/rubocop) static code analysis. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'solidus_jwt/factories'
```

Copyright (c) 2018 [name of extension creator], released under the New BSD License
