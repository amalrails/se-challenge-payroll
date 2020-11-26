# frozen_string_literal: true

class TimeReportRecord < ApplicationRecord
  belongs_to :time_report

  validates_presence_of :report_date, :hours_worked, :employee_id, :job_group_id
  validates :hours_worked, numericality: { greater_than: 0 }
end
