require 'bundler/setup'
Bundler.setup

require 'sidekiq'
require 'sidekiq/logging/json'

RSpec.configure do |config|
  # some (optional) config here
end
