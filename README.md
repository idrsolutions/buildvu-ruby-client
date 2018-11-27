# BuildVu Ruby Client #

Convert PDF to HTML5 or SVG with Ruby using the BuildVu Ruby Client to interact with IDRsolutions' [BuildVu Microservice Example](https://github.com/idrsolutions/buildvu-microservice-example).

The BuildVu Microservice Example is an open source project that allows you to convert PDF to HTML5 or SVG by running [BuildVu](https://www.idrsolutions.com/buildvu/) as a web service in the cloud or on-premise.

-----

# Installation #

## Using RubyGems: ##

Run the following command to install

    $ gem install buildvu

Alternatively, add this line to your application's Gemfile...

```ruby
gem 'buildvu'
```

...and then execute:

    $ bundle install

## Building the gem manually: ##

Run the following command to build the gem locally:

    $ gem build buildvu.gemspec

You can then install it using:

    $ gem install buildvu  

-----

# Usage #

## Basic: #

Setup the converter details by creating a new `BuildVu` object:
```ruby
require 'buildvu'
buildvu = BuildVu.new('localhost:8080/microservice-example')
```

You can now convert files by calling `convert`:
```ruby
# returns a URL where you can view the converted output in your web browser
puts buildvu.convert('/path/to/input/file')

# alternatively, you can specify a URL as input instead of uploading a file
puts buildvu.convert('http://link.to/file.pdf', input_type: BuildVu::DOWNLOAD)

# you can optionally specify a directory to download the converted output to
buildvu.convert('/path/to/input/file', output_file_path: '/path/to/output/dir')

# you can specify a URL that you want to be updated when the conversion finishes
buildvu.convert('/path/to/input/file', callback_url: 'http://listener.url')
```

See `example_usage.rb` for examples.

-----

# Who do I talk to? #

Found a bug, or have a suggestion / improvement? Let us know through the Issues page.

Got questions? You can contact us [here](https://idrsolutions.zendesk.com/hc/en-us/requests/new).

-----

# Code of Conduct #

Short version: Don't be an awful person.

Longer version: Everyone interacting in the BuildVu Ruby Client project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).  

-----
Copyright 2018 IDRsolutions

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
