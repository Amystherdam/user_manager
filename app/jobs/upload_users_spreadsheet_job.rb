# inside app/jobs/hello_world_job.rb
class UploadUsersSpreadsheetJob < ApplicationJob
  queue_as :default

  def perform(file_path, channel_key)
    users_spreadsheet = CreationUsersViaSpreadsheetService.new
    users_spreadsheet.process_file(file_path, channel_key)
  end
end
