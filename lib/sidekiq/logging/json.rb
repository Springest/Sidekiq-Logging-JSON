require "sidekiq/logging/json/version"
require "json"

module Sidekiq
  module Logging
    class Json < Sidekiq::Logging::Pretty
      # Provide a call() method that returns the formatted message.
      def call(severity, time, program_name, message)
        {
          '@timestamp' => time.utc.iso8601,
          pid: ::Process.pid,
          tid: "TID-#{Thread.current.object_id.to_s(36)}",
          context: "#{context}",
          severity: severity,
          message: message,
          program_name: program_name,
          type: 'sidekiq'
        }.to_json
      end
    end
  end
end
