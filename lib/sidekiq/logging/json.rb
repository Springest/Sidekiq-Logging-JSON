require "sidekiq/logging/json/version"
require "sidekiq/logging/json"
require "json"

module Sidekiq
  module Logging
    module Json
      class Logger < Sidekiq::Logging::Pretty
        # Provide a call() method that returns the formatted message.
        def call(severity, time, program_name, message)
          {
            '@timestamp' => time.utc.iso8601,
            '@fields' => {
              :pid => ::Process.pid,
              :tid => "TID-#{Thread.current.object_id.to_s(36)}",
              :context => "#{context}",
              :program_name => program_name
            },
            '@type' => 'sidekiq',
            '@status' => nil,
            '@severity' => severity,
            '@run_time' => nil,
            '@message' => "#{time.utc.iso8601} #{::Process.pid} TID-#{Thread.current.object_id.to_s(36)}#{context} #{severity}: #{message}",
          }.merge(process_message(message, severity)).to_json + "\n"
        end

        def process_message(message, severity)
          result = message.split(" ")
          {
            '@status' => result[0],                      # start or done
            '@run_time' => result[1] && result[1].to_f   # run time in seconds
          }
        end
      end
    end
  end
end
