[![Coverage Status](https://coveralls.io/repos/github/andela-gogbara/Shortr-gem/badge.svg?branch=master)](https://coveralls.io/github/andela-gogbara/Shortr-gem?branch=master) [![Circle CI](https://circleci.com/gh/andela-gogbara/Shortr-gem.svg?style=svg)](https://circleci.com/gh/andela-gogbara/Shortr-gem)
# # Shortr-gem
Shortr-gem provides access to all features of the [_Shortr URL shortening service_](http://github.com/andela-gogbara/Shortr) by integrating the Shortr API. With the gem, you can effortlessly create and update shortr links;

## Dependencies
You need to have Ruby set up on you machine. The gem is built using Ruby version _2.1.7_. Also, you need to have _bundler_ installed (especially if you are including the gem in another app or project).

## Installation
Add this line to your application's Gemfile
```ruby
gem 'shortr'
```
And then execute
```ruby
    $ bundle
```
Or install it yourself as
```ruby
    $ gem install shortr
```

## Usage
To starting using shortr, you need to require it. Do:
```ruby
    $ require 'shortr'
```
Or add to your code

Next you create an instance of the shortr gem:
```ruby
    $ shortr = Shortr::Link.new
```
Optionally, you can also instantiate with a valid token i.e

```ruby
    $ shortr = Shortr::Link.new(_your_valid_token_)
```

### With a _valid_ token
  In addition to the above methods
```ruby
    # To create a customized shortr
    $ shortr.create_new_short(_original-url_, _vanity-string_) #=> (original-url should be a valid url, vanity-string should be any alphanumeric character(s)) returns details of the created short link.
```

```ruby
    # To change the url target of a shortr
    $ shortr.change_short_target(_xxx_, _new-origin_) #=> (xxx is a valid shortr, new-origin is the new origin to assign to xxx) returns the updated shortr information
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andela-gogbara/shortr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
