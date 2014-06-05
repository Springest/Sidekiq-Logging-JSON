# Sidekiq::Logging::Json

At [Springest](http://www.springest.com), we use
[Logstash](http://logstash.net/) to ship all our logs to
[Elasticsearch](http://www.elasticsearch.org/). An Elasticsearch index
consists of JSON documents. To make it possible to make fine grained
queries on [Sidekiq](http://sidekiq.org/) logs, we needed logging in
JSON format. This gem contains that logger.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-logging-json'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install sidekiq-logging-json
```

## Usage

Add this to your Sidekiq configuration:

```ruby
Sidekiq.logger.formatter = Sidekiq::Logging::Json::Logger.new
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sidekiq-logging-json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
