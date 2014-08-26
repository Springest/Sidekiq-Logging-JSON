require 'spec_helper'

describe "Sidekiq::Logging::Json" do
  describe "process_message" do
    subject { JSON.parse(Sidekiq::Logging::Json::Logger.new.call(severity, time, program_name, logentry)) }
    let(:logentry) { "Some random message" }
    let(:message) { subject["@message"] }
    let(:status) { subject["@status"] }
    let(:run_time) { subject["@run_time"] }
    let(:severity) { "INFO" }
    let(:time) { Time.now }
    let(:program_name) { "RSpec" }

    it { expect( message ).to match(/#{logentry}/) }
    it { expect( status ).to eq(nil) }
    it { expect( run_time ).to eq(nil) }

    context "start" do
      let(:logentry) { "start" }

      it { expect( message ).to match(/#{logentry}/) }
      it { expect( status ).to eq("start") }
      it { expect( run_time ).to eq(nil) }
    end

    context "done" do
      let(:logentry) { "done: 51.579 sec" }

      it { expect( message ).to match(/#{logentry}/) }
      it { expect( status ).to eq("done") }
      it { expect( run_time ).to eq(51.579) }
    end

    context "exception" do
      let(:exception_message) { "This is the message that should be logged." }
      let(:logentry) { NoMethodError.new( exception_message ) }

      it { expect(message).to match( exception_message ) }
      it { expect( status ).to eq("exception") }
      it { expect( run_time ).to eq(nil) }
    end
  end
end
