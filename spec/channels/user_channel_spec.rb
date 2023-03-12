require 'rails_helper'

RSpec.describe UserChannel, type: :channel do
  it "receives user counters" do
    subscribe

    expect {
      ActionCable.server.broadcast(
        "user-count",
        {
          total_user_count: 10,
          admin_user_count: 2,
          common_user_count: 8
        }
      )
    }.to have_broadcasted_to("user-count").with(
      total_user_count: 10,
      admin_user_count: 2,
      common_user_count: 8
    )
  end

  it "unsubscribes successfully" do
    subscribe

    expect(subscription).to be_confirmed

    unsubscribe

    expect(subscription).to_not have_streams
  end
end
