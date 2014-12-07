# wichtler

secret santa single user webinterface

[![Build Status](https://travis-ci.org/manno/wichtler.svg?branch=master)](https://travis-ci.org/manno/wichtler)
[![Code Climate](https://codeclimate.com/github/manno/wichtler.png)](https://codeclimate.com/github/manno/wichtler)

## Install

### Ruby Version

ruby 2.1.3

### Deployment Instructions

Copy and edit all configuration templates.

* cp config/database.yml{.template,}
* cp config/initializers/action_mailer.rb{.template,}
* cp config/initializers/wichtler.rb{.template,}
* cp config/initializers/device_config.rb{.template,}
* cp config/secrets.yml{.template,}

Be sure to replace all secret tokens with randomly generated ones, i.e. by calling `rake secret`.
Configure your mail system and the hostname of the application.

### Database Creation

Setup your database in config/database.yml needed.

    rake db:setup

### Start a Server

To get the backend up and running:

    export RAILS_ENV=production
    bundle install
    rake db:setup
    rake assets:precompile
    rails s

## First Login

Login as user `admin@example.org` with password `media123`. Change these values after the first login.
