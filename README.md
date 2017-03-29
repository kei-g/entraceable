# Entraceable

Entraceable makes your methods garrulous.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'entraceable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install entraceable

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
  entraceable :add, tag: :TRACE, level: :debug
end
```

To disable:

```ruby
class Example
  distraceable :add
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kei-g/entraceable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [3-Clause BSD License](https://opensource.org/licenses/BSD-3-Clause)

