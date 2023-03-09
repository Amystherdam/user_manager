require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Enums' do
    it { is_expected.to(define_enum_for(:role).with_values(%i[admin common_user])) }
  end

  describe 'Validations' do
    it do
      is_expected.to(validate_presence_of(:full_name))
    end
  end
end
