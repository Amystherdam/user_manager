class UploadProgressChannel < ApplicationCable::Channel
  def subscribed
    channel_key = params[:channelKey]
    stream_from "upload_progress_channel_#{channel_key}"
  end

  def unsubscribed
    stop_all_streams
  end
end
