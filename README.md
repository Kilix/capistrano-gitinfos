# Capistrano-gitinfos

Capistrano 3 plugin to fetch git commit additional informations and store them in an INI/XML/YAML/JSON file when deploying

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-gitinfos'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-gitinfos

## Usage

```ruby
require 'capistrano/gitinfos'
```

Set the version file format and filename.

```ruby
# version file output format and file extension
# available formats : ini, xml, yml, json
# default : json
set :gitinfos_format, "json"

# relative path from release_path without file extension
# default : version
# if :gitinfos_format = yml and :gitinfos_file = config/version
# then the final path is <release_path>/config/version.yml
set :gitinfos_file, "version"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kilix/capistrano-gitinfos.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
