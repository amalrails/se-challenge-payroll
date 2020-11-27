# frozen_string_literal: true

# == Schema Information
#
# Table name: time_report_records
#
#  id             :integer          not null, primary key
#  report_date    :datetime
#  hours_worked   :decimal(5, 2)
#  employee_id    :integer          not null
#  job_group_id   :integer          not null
#  time_report_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_time_report_records_on_employee_id     (employee_id)
#  index_time_report_records_on_hours_worked    (hours_worked)
#  index_time_report_records_on_job_group_id    (job_group_id)
#  index_time_report_records_on_report_date     (report_date)
#  index_time_report_records_on_time_report_id  (time_report_id)
#
# Foreign Keys
#
#  employee_id     (employee_id => employees.id)
#  job_group_id    (job_group_id => job_groups.id)
#  time_report_id  (time_report_id => time_reports.id)
#
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
