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
class TimeReportRecord < ApplicationRecord
  belongs_to :time_report
  belongs_to :job_group
  belongs_to :employee

  validates_presence_of :report_date, :hours_worked, :employee_id, :job_group_id
  validates :hours_worked, numericality: { greater_than: 0 }

  scope :order_by_employee_id, -> { order(:employee_id) }
  scope :uniq_employee_ids, -> { pluck(:employee_id).uniq }
  scope :based_on_employee, ->(emp_id) { where(employee_id: emp_id) }
  scope :order_by_report_date, -> { order(:report_date) }
  scope :records_start_date, -> { first.report_date.beginning_of_month }
  scope :records_end_date, -> { last.report_date.end_of_month }
  scope :job_group, -> { first.job_group }
  scope :between_dates, ->(start_date, end_date) { where(report_date: start_date..end_date) }
end
