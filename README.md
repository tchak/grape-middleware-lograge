# A logger for Grape apps that uses [Lograge](https://github.com/roidrage/lograge)
[![Code Climate](https://codeclimate.com/github/tchak/grape-middleware-lograge/badges/gpa.svg)](https://codeclimate.com/github/tchak/grape-middleware-lograge) [![Gem Version](https://badge.fury.io/rb/grape-middleware-lograge.svg)](http://badge.fury.io/rb/grape-middleware-lograge)
[![Build Status](https://travis-ci.org/tchak/grape-middleware-lograge.svg)](https://travis-ci.org/tchak/grape-middleware-lograge)

Logs:
  * Request path
  * Parameters
  * Endpoint class name and handler
  * Response status
  * Duration of the request
  * Exceptions
  * Error responses from `error!`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape', '>= 0.14.0'
gem 'grape-middleware-lograge'
```

## Usage
```ruby
class API < Grape::API
  # @note Make sure this above you're first +mount+
  use Grape::Middleware::Lograge
end
```

Server requests will be logged to STDOUT by default.

## Custom setup
Customize the logging by passing the `filter` option. Example using parameter sanitization:
```ruby
use Grape::Middleware::Lograge, {
  filter: CustomFilter.new
}
```

The `filter` option can be any object that responds to `.filter(params_hash)`

## Example output
Get
```
Started GET "/v1/reports/101" at 2015-12-11 15:40:51 -0800
Processing by ReportsAPI#reports/:id
  Parameters: {"id"=>"101"}
Completed 200 in 6.29ms
```
Error
```
Started POST "/v1/reports" at 2015-12-11 15:42:33 -0800
Processing by ReportsAPI#reports
  Parameters: {"name"=>"foo", "password"=>"[FILTERED]"}
  Error: {:error=>"undefined something something bad", :detail=>"Whoops"}
Completed 422 in 6.29ms
```

## Using Rails?
`Rails.application.config.filter_parameters` will be used automatically as the default param filterer.

## Rack

If you're using the `rackup` command to run your server in development, pass the `-q` flag to silence the default rack logger.

## Credits

This code is forked from [grape-middleware-logger](https://github.com/ridiculous/grape-middleware-logger).

Big thanks to jadent's question/answer on [stackoverflow](http://stackoverflow.com/questions/25048163/grape-using-error-and-grapemiddleware-after-callback)
for easily logging error responses. Borrowed some motivation from the [grape_logging](https://github.com/aserafin/grape_logging) gem
and would love to see these two consolidated at some point.

## Contributing

1. Fork it ( https://github.com/tchak/grape-middleware-lograge/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
