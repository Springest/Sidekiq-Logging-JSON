This project is **no longer maintained**.

If you're interested in taking it over, we'd love to hear from you.
[Email us](developers@springest.com), or check out one of its maintained forks.

*****

# Sidekiq::Logging::Json

At [Springest](http://www.springest.com), we use
[Logstash](http://logstash.net/) to ship all our logs to
[Elasticsearch](http://www.elasticsearch.org/). An Elasticsearch index
consists of JSON documents. To make it possible to make fine grained
queries on [Sidekiq](http://sidekiq.org/) logs, we needed logging in
JSON format. This gem contains that logger.

### Example log entry:

```json
{
  "@timestamp": "2014-06-05T12:38:42Z",
  "pid": 8630,
  "tid": "TID-osammcf2k",
  "context": "TrainingIndexer::Work JID-177066e96052c2314dcad8c7",
  "severity": "INFO",
  "program_name": "TrainingIndexer::Work",
  "type": "sidekiq",
  "message": "2014-06-05T12:38:42Z 8630 TID-osammcf2k TrainingIndexer::Work JID-177066e96052c2314dcad8c7 INFO: done: 51.579 sec",
  "status": "done",
  "run_time": 51.579
}
```

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
require 'sidekiq/logging/json'

Sidekiq.logger.formatter = Sidekiq::Logging::Json::Logger.new
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sidekiq-logging-json/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
