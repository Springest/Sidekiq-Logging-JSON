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
            :pid => ::Process.pid,
            :tid => "TID-#{Thread.current.object_id.to_s(36)}",
            :context => "#{context}",
            :severity => severity,
            :program_name => program_name,
            :type => 'sidekiq',
            :status => nil,
            :run_time => nil
          }.merge(process_message(message)).to_json + "\r\n"
        end

        def process_message(message)
          result = message.match(/INFO: (done|start)(: ([0-9\.]+) sec)?$/)

          return { message: message } unless result

          {
            :message => message,                       # The full message
            :status => result[1],                      # start or done
            :run_time => result[3] && result[3].to_f   # run time in seconds
          }
        end
      end
    end
  end
end
