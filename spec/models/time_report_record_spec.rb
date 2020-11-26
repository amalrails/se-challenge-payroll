# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeReportRecord, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:report_date) }
    it { should validate_presence_of(:hours_worked) }
    it { should validate_presence_of(:employee_id) }
    it { should validate_presence_of(:job_group_id) }
    it { should validate_numericality_of(:hours_worked) }
    it { should allow_value(9).for(:hours_worked) }
    it { should_not allow_value('t').for(:hours_worked) }
    it { should_not allow_value(0).for(:hours_worked) }
  end

  describe 'Associations' do
    it { should belong_to(:time_report) }
  end
end
