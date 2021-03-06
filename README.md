Capistrano-gitinfos
===================

[![Build Status](https://travis-ci.org/Kilix/capistrano-gitinfos.svg?branch=master)](https://travis-ci.org/Kilix/capistrano-gitinfos)

Capistrano 3 plugin to fetch git commit additional informations and store them in an INI/XML/YAML/JSON file when deploying

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-gitinfos'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-gitinfos

Usage
-----

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

# section name : "namespace" in the config file which will contains git commit informations
# if the namespace contains dots, it will be translated as nested path in JSON, YML and XML
set :gitinfos_section, ''
```

After deploying, you will get a file with the following informations:

* full_commit : git full SHA1 commit
* abbrev_commit : git abbrev SHA1 commit
* version : the result of `git describe --tags` command if possible, otherwise the abbrev commit
* commit_date : commit date in IS08601 format (with timezone)
* commit_timestamp : commit date in unix timestamp format
* deploy_date : capistrano deploy date in IS08601 format (with timezone)
* deploy_timestamp : capistrano deploy date in unix timestamp format

e.g. :

* version.json

```json
{
  "commit_date": "2015-11-25T16:25:50+0000",
  "full_commit": "576e27c6ebcef6987f143e1468a815eaf2eb8bc1",
  "version": "v0.8.0-268-g576e27c",
  "commit_timestamp": "1448468750",
  "deploy_date": "2015-11-25T16:45:39+0000",
  "deploy_timestamp": "1448469939",
  "abbrev_commit": "576e27c"
}
```

with `:gitinfos_section` = 'parameters.git'

```json
{
  "parameters": {
    "git": {
      "commit_date": "2015-11-25T16:25:50+0000",
      "full_commit": "576e27c6ebcef6987f143e1468a815eaf2eb8bc1",
      "version": "v0.8.0-268-g576e27c",
      "commit_timestamp": "1448468750",
      "deploy_date": "2015-11-25T16:45:39+0000",
      "deploy_timestamp": "1448469939",
      "abbrev_commit": "576e27c"
    }
  }
}
```

* version.ini

```ini
[app_version]
commit_date = 2015-11-25T16:25:50+0000
full_commit = 576e27c6ebcef6987f143e1468a815eaf2eb8bc1
version = v0.8.0-268-g576e27c
commit_timestamp = 1448468750
deploy_date = 2015-11-25T16:45:43+0000
deploy_timestamp = 1448469943
abbrev_commit = 576e27c
```

with `:gitinfos_section` = 'parameters.git'

```ini
[parameters.git]
commit_date = 2015-11-25T16:25:50+0000
full_commit = 576e27c6ebcef6987f143e1468a815eaf2eb8bc1
version = v0.8.0-268-g576e27c
commit_timestamp = 1448468750
deploy_date = 2015-11-25T16:45:43+0000
deploy_timestamp = 1448469943
abbrev_commit = 576e27c
```

* version.yml

```yml
abbrev_commit: 576e27c
commit_date: 2015-11-25T16:25:50+0000
commit_timestamp: '1448468750'
deploy_date: 2015-11-25T16:45:41+0000
deploy_timestamp: '1448469941'
full_commit: 576e27c6ebcef6987f143e1468a815eaf2eb8bc1
version: v0.8.0-268-g576e27c
```

with `:gitinfos_section` = 'parameters.git'

```yml
parameters:
  git:
    abbrev_commit: '576e27c'
    commit_date: '2015-11-25T16:25:50+0000'
    commit_timestamp: '1448468750'
    deploy_date: '2015-11-25T16:45:41+0000'
    deploy_timestamp: '1448469941'
    full_commit: '576e27c6ebcef6987f143e1468a815eaf2eb8bc1'
    version: 'v0.8.0-268-g576e27c'
```

* version.xml

```xml
<?xml version='1.0' encoding='UTF-8'?>
<app_version>
  <commit_date>2015-11-25T16:25:50+0000</commit_date>
  <full_commit>576e27c6ebcef6987f143e1468a815eaf2eb8bc1</full_commit>
  <version>v0.8.0-268-g576e27c</version>
  <commit_timestamp>1448468750</commit_timestamp>
  <deploy_date>2015-11-25T16:45:48+0000</deploy_date>
  <deploy_timestamp>1448469948</deploy_timestamp>
  <abbrev_commit>576e27c</abbrev_commit>
</app_version>
```

with `:gitinfos_section` = 'parameters.git'

```xml
<?xml version='1.0' encoding='UTF-8'?>
<parameters>
  <git>
    <commit_date>2015-11-25T16:25:50+0000</commit_date>
    <full_commit>576e27c6ebcef6987f143e1468a815eaf2eb8bc1</full_commit>
    <version>v0.8.0-268-g576e27c</version>
    <commit_timestamp>1448468750</commit_timestamp>
    <deploy_date>2015-11-25T16:45:48+0000</deploy_date>
    <deploy_timestamp>1448469948</deploy_timestamp>
    <abbrev_commit>576e27c</abbrev_commit>
  </git>
</parameters>
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/kilix/capistrano-gitinfos.

License
-------

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
