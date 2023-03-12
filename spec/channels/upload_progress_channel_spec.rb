require 'rails_helper'

RSpec.describe UploadProgressChannel, type: :channel do
  let(:channel_key) { "123" }

  it "receives progress updates" do
    subscribe(channelKey: channel_key)

    expect { 
      ActionCable.server.broadcast("upload_progress_channel_#{channel_key}", {progress: 50})
    }.to have_broadcasted_to("upload_progress_channel_#{channel_key}").with(progress: 50)
  end

  it "unsubscribes successfully" do
    subscribe(channelKey: channel_key)
    expect(subscription).to be_confirmed

    unsubscribe

    expect(subscription).to_not have_streams
  end
end
