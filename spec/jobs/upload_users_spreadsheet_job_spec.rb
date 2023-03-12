require 'rails_helper'

RSpec.describe UploadUsersSpreadsheetJob, type: :job do
  describe '#perform' do
    let(:file_path) { 'path/to/file.xlsx' }
    let(:channel_key) { 'channel-key' }
    let(:users_spreadsheet) { instance_double(CreationUsersViaSpreadsheetService) }

    before do
      allow(CreationUsersViaSpreadsheetService).to receive(:new).and_return(users_spreadsheet)
      allow(users_spreadsheet).to receive(:process_file)
    end

    it 'creates users from a spreadsheet' do
      described_class.perform_now(file_path, channel_key)
      expect(users_spreadsheet).to have_received(:process_file).with(file_path, channel_key)
    end

    it 'is in the default queue' do
      expect(described_class.new.queue_name).to eq('default')
    end
  end
end
