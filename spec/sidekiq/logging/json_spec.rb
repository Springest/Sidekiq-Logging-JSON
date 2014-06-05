require 'spec_helper'

describe "Sidekiq::Logging::Json" do
  describe "process_message" do
    subject { Sidekiq::Logging::Json::Logger.new.process_message(logentry) }
    let(:logentry) { "Some random message" }
    let(:message) { subject[:message] }
    let(:status) { subject[:status] }
    let(:run_time) { subject[:run_time] }

    it { expect( message ).to eq(logentry) }
    it { expect( status ).to eq(nil) }
    it { expect( run_time ).to eq(nil) }

    context "start" do
      let(:logentry) { "2014-06-05T12:38:55Z 8630 TID-osanfu5nw SubjectClickthroughTracker JID-e17a9e9ca0521bb74b423166 INFO: start" }

      it { expect( message ).to eq(logentry) }
      it { expect( status ).to eq("start") }
      it { expect( run_time ).to eq(nil) }
    end

    context "done" do
      let(:logentry) { "2014-06-05T12:38:42Z 8630 TID-osammcf2k TrainingIndexer::Work JID-177066e96052c2314dcad8c7 INFO: done: 51.579 sec" }

      it { expect( message ).to eq(logentry) }
      it { expect( status ).to eq("done") }
      it { expect( run_time ).to eq(51.579) }
    end
  end
end
