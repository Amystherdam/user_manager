require 'rails_helper'

RSpec.describe CreationUsersViaSpreadsheetService do

  let(:users_spreadsheet_service) { CreationUsersViaSpreadsheetService.new }

  let(:channel_key) { "123" }

  let(:file_path) {
    Rails.root.join('spec', 'fixtures', 'files', 'example.xlsx')
  }

  it '#process_file' do
    expect { users_spreadsheet_service.process_file(file_path, channel_key) }.to change(User, :count).by(1)
  end
end
