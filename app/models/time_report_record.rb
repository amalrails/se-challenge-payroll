# frozen_string_literal: true

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
