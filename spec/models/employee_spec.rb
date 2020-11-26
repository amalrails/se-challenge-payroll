# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Associations' do
    it { should belong_to(:job_group) }
    it { should have_many(:time_report_records) }
  end
end
