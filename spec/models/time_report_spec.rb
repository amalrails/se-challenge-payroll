# frozen_string_literal: true

# == Schema Information
#
# Table name: time_reports
#
#  id         :integer          not null, primary key
#  name       :string(20)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe TimeReport, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should allow_value('time-report-42.csv').for(:name) }
    it { should_not allow_value('test42.csv').for(:name) }
  end
end
