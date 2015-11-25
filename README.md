# wichtler

secret santa single user webinterface

[![Build Status](https://travis-ci.org/manno/wichtler.svg?branch=master)](https://travis-ci.org/manno/wichtler)
[![Code Climate](https://codeclimate.com/github/manno/wichtler.png)](https://codeclimate.com/github/manno/wichtler)

## Install

### Ruby Version

ruby 2.1.3

### Deployment Instructions

Be sure to replace all secret tokens with randomly generated ones, i.e. by calling `rake secret`.
Set these environment variables:

    SECRET_KEY_BASE=1234
    DEVISE_SECRET_KEY=1234
    DEVISE_MAIL_SENDER=root@localhost
    VHOST=appname.localdomain
    VHOST_PROTOCOL=http
    MAIL_HOST=smpt.localdomain
    MAIL_USER=user
    MAIL_PASSWORD=password
    MAIL_AUTH_TYPE=login
    FROM_EMAIL=replyto@localhost

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

# Dokku Deployment

## Add your SSH key to dokku

On development box:

    cat ~/.ssh/id_rsa.pub | ssh root@dokku.example.com "sshcommand acl-add dokku dokku-keys"

## Create dokku app

On dokku server:

    dokku apps:create wichtler
    sudo dokku plugin:install https://github.com/dokku/dokku-postgres.git
    dokku postgres:create wichtler-db
    dokku postgres:link wichtler-db wichtler
    dokku domains:add wichtler wichtler.example.com

## Configure

On dokku server, change values:

    dokku config:set wichtler RAILS_STDOUT_LOGGING=true
    dokku config:set wichtler RAILS_SERVE_STATIC_FILES=true
    dokku config:set wichtler DEVISE_SECRET_KEY=$KEY
    dokku config:set wichtler DEVISE_MAIL_SENDER=test@example.com
    dokku config:set wichtler VHOST=wichtler.example.com
    dokku config:set wichtler VHOST_PROTOCOL=http
    dokku config:set wichtler MAIL_HOST=mail.example.com
    dokku config:set wichtler MAIL_USER=user
    dokku config:set wichtler MAIL_PASSWORD=password
    dokku config:set wichtler MAIL_AUTH_TYPE=login
    dokku config:set wichtler FROM_EMAIL=user@example.com
    dokku config:set wichtler SECRET_KEY_BASE=$OTHER_KEY

## Deploy

On development box:

	LC_ALL=C git push -f dokku dokku@$dokku_host:master
