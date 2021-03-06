# Entraceable

Entraceable makes your methods garrulous.

[![Travis CI](https://img.shields.io/travis/com/kei-g/entraceable?logo=travis&style=plastic)](https://www.travis-ci.com/github/kei-g/entraceable)
[![Gem](https://img.shields.io/gem/v/entraceable?logo=rubygems&style=plastic)](https://rubygems.org/gems/entraceable/)
[![License](https://img.shields.io/github/license/kei-g/entraceable?style=plastic)](https://opensource.org/licenses/BSD-3-Clause)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'entraceable'
```

And then execute:

```shell
bundle
```

Or install it yourself as:

```shell
gem install entraceable
```

## Usage

For example, you have a class like below:

```ruby
class Example
  def add(a, b)
    a + b
  end
end
```

To make it garrulous:

```ruby
require 'entraceable'

class Example
  entraceable :add
end
```

To disable:

```ruby
class Example
  distraceable :add
end
```

### Tag and Level

Tag and level are available:

```ruby
class Example
  entraceable :add, tag: "Example"
  entraceable :sub, level: :warn
end
```

### Enable, or disable, all entracabled things

Entraceable is enabled only for development environment.
To enable for production environment:

```ruby
Entraceable.enable
```

To disable:

```ruby
Entraceable.disable
```

### Preference

Entraceable is able to be configured also like below:

```ruby
class MyEntraceablePreference < Entraceable::Preference
  def enabled?
    # fetch a column from your database
  end
end

Entraceable.preference = MyEntraceablePreference.new
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/kei-g/entraceable). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [3-Clause BSD License](https://opensource.org/licenses/BSD-3-Clause)
