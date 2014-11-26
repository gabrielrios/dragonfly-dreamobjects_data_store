# Dragonfly::S3DataStore

Dreamobjects data store for use with the [Dragonfly](http://github.com/markevans/dragonfly) gem.

Heavily inspired on [Dragonfly::S3DataStore](http://github.com/markevans/dragonfly-s3_data_storage) gem

## Gemfile

```ruby
gem 'dragonfly-dreamobjects_data_store'
```

## Usage
Configuration (remember the require)

```ruby
require 'dragonfly/s3_data_store'

Dragonfly.app.configure do
  # ...

  datastore :dreamobjects,
    bucket_name: 'my-bucket',
    access_key_id: 'blahblahblah',
    secret_access_key: 'blublublublu'

  # ...
end
```

### Available configuration options

```ruby
:bucket_name
:access_key_id
:secret_access_key
:endpoint  # Dreamobjects Server URL
```

