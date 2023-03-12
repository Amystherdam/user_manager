require 'rubyXL'

class CreationUsersViaSpreadsheetService
  def process_file(file_path, channel_key)
    workbook = RubyXL::Parser.parse(file_path)
    worksheet = workbook[0]

    total_lines = worksheet.count

    worksheet.each_with_index do |row, lines_processed|
      next if lines_processed.zero?
      break if row[0].value.nil?

      full_name = row[0]&.value
      email = row[1]&.value
      password = row[2]&.value
      role = row[3]&.value || 1

      if User.create(full_name:, email:, password:, role:)
        user_service = UserService.new
        ActionCable.server.broadcast(
          'user-count',
          {
            total_user_count: user_service.user_counts[:all],
            admin_user_count: user_service.user_counts[:role_admin],
            common_user_count: user_service.user_counts[:role_common]
          }
        )
      end

      progress = (lines_processed.to_f / (total_lines - 1) * 100).round(2)

      ActionCable.server.broadcast("upload_progress_channel_#{channel_key}", { progress: progress })
    end

    File.delete(file_path) unless File.dirname(file_path).include?('fixtures')
  end
end
