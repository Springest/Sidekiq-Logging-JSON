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
              :program_name => program_name,
              :worker => "#{context}".split(" ")[0]
            },
            '@type' => 'sidekiq',
            '@status' => nil,
            '@severity' => severity,
            '@run_time' => nil,
            '@message' => "#{time.utc.iso8601} #{::Process.pid} TID-#{Thread.current.object_id.to_s(36)}#{context} #{severity}: #{message}",
          }.merge(process_message(severity, time, program_name, message)).to_json + "\n"
        end

        def process_message(severity, time, program_name, message)
          return { '@status' => 'exception' } if message.is_a?(Exception)

          if message.is_a? Hash
            if message["retry"]
              status = "retry"
              msg = "#{message['class']} failed, retrying with args #{message['args'].to_s[0..400]}."
            else
              status = "dead"
              msg = "#{message['class']} failed with args #{message['args'].to_s[0..400]}, not retrying."
            end
            return {
              '@status' => status,
              '@message' => "#{time.utc.iso8601} #{::Process.pid} TID-#{Thread.current.object_id.to_s(36)}#{context} #{severity}: #{msg}"
            }
          end

          result = message.split(" ")
          status = result[0].match(/^(start|done|fail):?$/) || []

          {
            '@status' => status[1],                                   # start or done
            '@run_time' => status[1] && result[1] && result[1].to_f   # run time in seconds
          }
        end
      end
    end
  end
end
